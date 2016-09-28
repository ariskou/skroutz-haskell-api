{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE GADTs                 #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE PartialTypeSignatures #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.FixtureGenerator
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides a function which generates JSON fixtures for tests.
----------------------------------------------------------------------------
module Web.Skroutz.FixtureGenerator
(
  generateFixtures
)
where

import           Control.Monad.Trans.Except (runExceptT)
import qualified Data.ByteString            as B
import qualified Data.ByteString.Lazy       as BL
import           Data.Either.Combinators    (fromRight')
import           Data.HList                 (ApplyAB, applyAB, hMapM_)
import           Data.Text                  (pack)
import           Data.Text.Encoding         (encodeUtf8)
import           Network.HTTP.Client        (httpLbs, method, newManager,
                                             parseRequest, requestHeaders,
                                             responseBody, responseStatus)
import           Network.HTTP.Types.Status  (statusCode)
import           System.Directory           (getCurrentDirectory)
import           System.Environment         (getEnv)
import           System.FilePath            ((</>))
import qualified Web.Skroutz                as Skroutz
import           Web.Skroutz.ApiEntries     (apiEntries)

apiIdentifierEnvKey :: String
apiIdentifierEnvKey = "API_IDENTIFIER"

apiSecretEnvKey :: String
apiSecretEnvKey = "API_SECRET"

apiEntrypoint :: String
apiEntrypoint = "http://api.skroutz.gr"

getAuthToken :: IO B.ByteString
getAuthToken = do
  apiIdentifier <- getEnv apiIdentifierEnvKey
  apiSecret <- getEnv apiSecretEnvKey
  manager <- newManager Skroutz.defaultAuthManagerSettings

  result <- runExceptT $ Skroutz.getToken
    (Just $ pack apiIdentifier)
    (Just $ pack apiSecret)
    (Just Skroutz.defaultAuthPublicGrantType)
    (Just Skroutz.defaultAuthPublicRedirectUri)
    (Just Skroutz.defaultAuthPublicScope)
    manager
    Skroutz.defaultAuthBaseUrl

  return $ encodeUtf8 $ Skroutz._tokenAccessToken $ fromRight' result

getFixtureDir :: IO FilePath
getFixtureDir = do
  dir <- getCurrentDirectory
  return $ dir </> "test" </> "fixtures" </> "generated"

saveFixture :: B.ByteString -> String -> String -> IO ()
saveFixture authToken fixtureName fixtureApiPath = do
  manager <- newManager Skroutz.defaultDataManagerSettings
  initialRequest <- parseRequest (apiEntrypoint ++ fixtureApiPath)
  let request = initialRequest { method = "GET", requestHeaders = [("accept", "application/vnd.skroutz+json; version=3"), ("authorization", "Bearer " `B.append` authToken)]}

  response <- httpLbs request manager
  putStrLn $ fixtureName ++ ": The status code was: " ++ show (statusCode $ responseStatus response)
  fixtureDir <- getFixtureDir
  BL.writeFile (fixtureDir </> fixtureName ++ ".json") (responseBody response)

data HSaveFixtureT = HSaveFixtureT B.ByteString

instance (from ~ (String, String, _a, _b), to ~ IO () ) => ApplyAB HSaveFixtureT from to where
  applyAB (HSaveFixtureT authToken) (fixtureName, fixtureApiPath, _, _) = saveFixture authToken fixtureName fixtureApiPath

generateFixtures :: IO ()
generateFixtures = do
  authToken <- getAuthToken
  hMapM_ (HSaveFixtureT authToken) apiEntries
