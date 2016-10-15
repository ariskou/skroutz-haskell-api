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
-- Portability :  non-portable
--
-- Provides a function which generates JSON fixtures for tests.
----------------------------------------------------------------------------
module Web.Skroutz.FixtureGenerator
(
  generateFixtures
)
where

import qualified Data.ByteString                as B
import qualified Data.ByteString.Lazy           as BL
import           Data.Either.Combinators        (fromRight')
import           Data.Foldable                  (traverse_)
import           Data.Text                      (pack)
import           Data.Text.Encoding             (encodeUtf8)
import           Network.HTTP.Client            (httpLbs, method, newManager, parseRequest, requestHeaders, responseBody, responseHeaders, responseStatus)
import           Network.HTTP.Types.Status      (statusCode)
import           System.FilePath                ((</>))
import qualified Web.Skroutz                    as Skroutz
import           Web.Skroutz.ApiEntries         (ApiEntry, apiEntries)
import           Web.Skroutz.TestingEnvironment (getAuthToken, getFixtureDir)

saveFixture :: B.ByteString -> ApiEntry -> IO ()
saveFixture authToken (fixtureName, fixtureApiPath, _, _) = do
  manager <- newManager Skroutz.defaultDataManagerSettings
  initialRequest <- parseRequest fixtureApiPath
  let request = initialRequest { method = "GET", requestHeaders = [("accept", "application/vnd.skroutz+json; version=3"), ("authorization", "Bearer " `B.append` authToken)]}

  response <- httpLbs request manager
  putStrLn $ fixtureName ++ ": The status code was: " ++ show (statusCode $ responseStatus response)
  fixtureDir <- getFixtureDir
  BL.writeFile (fixtureDir </> "generated" </> fixtureName ++ ".json") (responseBody response)
  B.writeFile (fixtureDir </> "generated" </> fixtureName ++ ".headers") $ encodeUtf8 $ pack $ show (responseHeaders response)

generateFixtures :: IO ()
generateFixtures = do
  authToken <- getAuthToken
  traverse_ (saveFixture (fromRight' authToken)) apiEntries
