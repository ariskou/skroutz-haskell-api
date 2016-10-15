{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE GADTs                 #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE PartialTypeSignatures #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE UndecidableInstances  #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.EndpointsSpec
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :  non-portable
--
-- Provides the Hspec tests for the "live" API endpoints.
----------------------------------------------------------------------------
module Web.Skroutz.EndpointsSpec
where

import           Data.Either                    (isRight)
import           Data.Either.Combinators        (fromRight', mapRight)
import           Data.Foldable                  (traverse_)
import           Data.Text                      (Text)
import           Data.Text.Encoding             (decodeUtf8)
import           Network.HTTP.Client            (newManager)
import           Servant.API.ResponseHeaders    (Headers)
import           Servant.Client                 (ServantError)
import           Test.Hspec                     (Spec, SpecWith, beforeAll, describe, hspec, it, shouldBe, shouldSatisfy)
import qualified Web.Skroutz                    as Skroutz
import           Web.Skroutz.ApiEntries         (ApiEntry, apiEntries)
import           Web.Skroutz.FixtureGenerator
import           Web.Skroutz.TestingEnvironment (getAuthToken)

-- So that we can print an error if the test fails
instance Show (Headers a b) where
  show _ = ""

liveApiSpec :: ApiEntry -> SpecWith (Either ServantError Text)
liveApiSpec (testName, _, checkApiCaller, _) =
  it testName $ \eitherAuthToken -> do
    isRight eitherAuthToken `shouldBe` True -- Do not reveal client_id and client_secret on test failure
    let authToken = fromRight' eitherAuthToken

    manager <- newManager Skroutz.defaultDataManagerSettings
    eitherResponse <- checkApiCaller authToken manager
    eitherResponse `shouldSatisfy` isRight

spec :: Spec
spec = do
  describe "Requesting data via the API endpoints from the live, remote webservice and parsing the JSON results" $
    it "retrieves an authorization token" $ do
      eitherAuthToken <- getAuthToken
      isRight eitherAuthToken `shouldBe` True -- Do not reveal client_id and client_secret on test failure
  beforeAll (fmap (mapRight decodeUtf8) getAuthToken) $
    describe "Requesting data via the API endpoints from the live, remote webservice and parsing the JSON results" $ traverse_ liveApiSpec apiEntries

main :: IO ()
main = hspec spec
