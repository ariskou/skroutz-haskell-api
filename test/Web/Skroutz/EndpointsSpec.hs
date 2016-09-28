{-# LANGUAGE ExplicitForAll        #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE GADTs                 #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE PartialTypeSignatures #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE UndecidableInstances  #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.EndpointsSpec
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Hspec tests for the "live" API endpoints.
----------------------------------------------------------------------------
module Web.Skroutz.EndpointsSpec
where

import           Control.Monad.Trans.Except     (ExceptT, runExceptT)
import qualified Data.Aeson                     as Aeson
import           Data.Dynamic
import           Data.Either
import           Data.HList                     (ApplyAB, applyAB, hMapM_)
import           Data.Text                      (Text)
import           Data.Text.Encoding             (decodeUtf8)
import           Network.HTTP.Client            (Manager, newManager)
import           Servant.API.ResponseHeaders    (Headers)
import           Servant.Client
import           Test.Hspec                     (Spec, SpecWith, beforeAll,
                                                 describe, hspec, it,
                                                 shouldSatisfy)
import qualified Web.Skroutz                    as Skroutz
import           Web.Skroutz.ApiEntries         (apiEntries)
import           Web.Skroutz.TestingEnvironment

-- So that we can print an error if the test fails
instance Show (Headers a b) where
  show _ = ""

liveApiSpec :: forall a . (Show a, Aeson.FromJSON a, Aeson.ToJSON a) => Proxy a -> String -> (Text -> Manager -> ExceptT ServantError IO (Skroutz.WithHeaders a)) -> SpecWith Text
liveApiSpec _ testName testApiCall =
  it testName $ \authToken -> do
    manager <- newManager Skroutz.defaultDataManagerSettings
    let exceptT = testApiCall authToken manager
    (eitherResponse :: Either ServantError (Skroutz.WithHeaders a)) <- runExceptT exceptT
    eitherResponse `shouldSatisfy` isRight

data HLiveApiT = HLiveApiT

instance (from ~ (String, String, Text -> Manager -> ExceptT ServantError IO (Skroutz.WithHeaders a), Proxy a), to ~ SpecWith Text, Show a, Aeson.FromJSON a, Aeson.ToJSON a) => ApplyAB HLiveApiT from to where
  applyAB HLiveApiT (testName, _, testApiCall, testApiReturnTypeProxy) = liveApiSpec testApiReturnTypeProxy testName testApiCall

spec :: Spec
spec = do
  describe "JSON Parsing of the real, live API" $
    it "retrieves an authorization token" $ do
      _ <- getAuthToken
      return ()
  beforeAll (fmap decodeUtf8 getAuthToken) $
    describe "retrieves and parses JSON API responses" $ hMapM_ HLiveApiT apiEntries

main :: IO ()
main = hspec spec
