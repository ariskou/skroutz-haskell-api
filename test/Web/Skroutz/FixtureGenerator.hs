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

import qualified Data.ByteString                as B
import qualified Data.ByteString.Lazy           as BL
import           Data.HList                     (ApplyAB, applyAB, hMapM_)
import           Network.HTTP.Client            (httpLbs, method, newManager, parseRequest, requestHeaders, responseBody, responseStatus)
import           Network.HTTP.Types.Status      (statusCode)
import           System.FilePath                ((</>))
import qualified Web.Skroutz                    as Skroutz
import           Web.Skroutz.ApiEntries         (apiEntries)
import           Web.Skroutz.TestingEnvironment

saveFixture :: B.ByteString -> String -> String -> IO ()
saveFixture authToken fixtureName fixtureApiPath = do
  manager <- newManager Skroutz.defaultDataManagerSettings
  initialRequest <- parseRequest fixtureApiPath
  let request = initialRequest { method = "GET", requestHeaders = [("accept", "application/vnd.skroutz+json; version=3"), ("authorization", "Bearer " `B.append` authToken)]}

  response <- httpLbs request manager
  putStrLn $ fixtureName ++ ": The status code was: " ++ show (statusCode $ responseStatus response)
  fixtureDir <- getFixtureDir
  BL.writeFile (fixtureDir </> "generated" </> fixtureName ++ ".json") (responseBody response)

data HSaveFixtureT = HSaveFixtureT B.ByteString

instance (from ~ (String, String, _a, _b), to ~ IO () ) => ApplyAB HSaveFixtureT from to where
  applyAB (HSaveFixtureT authToken) (fixtureName, fixtureApiPath, _, _) = saveFixture authToken fixtureName fixtureApiPath

generateFixtures :: IO ()
generateFixtures = do
  authToken <- getAuthToken
  hMapM_ (HSaveFixtureT authToken) apiEntries
