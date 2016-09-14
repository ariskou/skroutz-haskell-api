{-# LANGUAGE DataKinds                 #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE OverloadedStrings         #-}
{-# LANGUAGE TypeOperators             #-}
-- --{-# LANGUAGE ScopedTypeVariables       #-}
{-# LANGUAGE AllowAmbiguousTypes       #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE FlexibleInstances         #-}
{-# LANGUAGE FunctionalDependencies    #-}
{-# LANGUAGE GADTs                     #-}
{-# LANGUAGE ImpredicativeTypes        #-}
{-# LANGUAGE InstanceSigs              #-}
{-# LANGUAGE KindSignatures            #-}
{-# LANGUAGE MultiParamTypeClasses     #-}
{-# LANGUAGE RankNTypes                #-}
-- {-# LANGUAGE ScopedTypeVariables       #-}
{-# LANGUAGE UndecidableInstances      #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endpoints.SampleCalls
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Hspec tests for the 'Shop' type.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.SampleCalls
where

import           Control.Monad.Trans.Except (ExceptT, runExceptT)
import           Data.Dynamic
import           Data.Either
import           Data.HList
import           Data.Map
import           Data.Maybe
import           Data.Monoid                ((<>))
import           Data.Text                  (Text, pack, unpack)
import           GHC.Base
import           Network.HTTP.Client        (Manager, ManagerSettings,
                                             defaultManagerSettings, newManager)
import           Servant.API                hiding (HNil)
import           Servant.Client
import           System.Environment         (getEnv)
import qualified Web.Skroutz                as Skroutz
import           Web.Skroutz.Common

defaultPage :: Maybe Int
defaultPage = Just 1

defaultPer :: Maybe Int
defaultPer = Just 25

defaultDataAcceptHeader :: Maybe Text
defaultDataAcceptHeader = Just Skroutz.defaultDataAcceptHeader

defaultAuthToken :: Text -> Maybe Text
defaultAuthToken = Just . Skroutz.makeAuthToken

leftToMaybe :: Either a b -> Maybe a
leftToMaybe = either Just (const Nothing)

rightToMaybe :: Either a b -> Maybe b
rightToMaybe = either (const Nothing) Just

makeDataCalls :: Text -> Manager -> Data.HList.HList '[
    ExceptT ServantError IO (Skroutz.WithHeaders Skroutz.MultipleCategoryResponse)
  , ExceptT ServantError IO (Skroutz.WithHeaders Skroutz.SingleCategoryResponse)]
makeDataCalls authToken manager =
  withStdParamsPagedDefaults Skroutz.getCategories
  .*. withStdParams (Skroutz.getCategory 1)
  .*. HNil
  where
    withStdParams f = f defaultDataAcceptHeader (defaultAuthToken authToken) manager Skroutz.defaultDataBaseUrl
    withStdParamsPaged page per f = f page per defaultDataAcceptHeader (defaultAuthToken authToken) manager Skroutz.defaultDataBaseUrl
    withStdParamsPagedDefaults = withStdParamsPaged defaultPage defaultPer

authTokenEnvName :: String
authTokenEnvName = "SKROUTZ_API_AUTHORIZATION_TOKEN"

-- keepError :: ExceptT ServantError IO a -> IO (Maybe ServantError)
-- keepError dataCall = do
--   result <- runExceptT dataCall
--   return $ case result of
--     Left err -> Just err
--     Right _ -> Nothing

data HExceptT = HExceptT

instance (from ~ ExceptT error IO success, to ~  IO (Either error success) ) => ApplyAB HExceptT from to where
  applyAB HExceptT = runExceptT

data HLeftToMaybe = HLeftToMaybe

instance (from ~ Either a b, to ~ Maybe a) => ApplyAB HLeftToMaybe from to where
  applyAB HLeftToMaybe = leftToMaybe


data HRightToMaybe = HRightToMaybe

instance (from ~ Either a b, to ~ Maybe b) => ApplyAB HRightToMaybe from to where
  applyAB HRightToMaybe = rightToMaybe

data HResponse = HResponse

instance (from ~ (Maybe (Headers ls a))) => ApplyAB HResponse from a where
  applyAB HResponse = getResponse . fromJust

-- dataCallResultsM :: (a ~ ExceptT error IO success, b ~ IO (Either error success)) => Data.HList.HList '[a] -> Data.HList.HList '[b]
-- dataCallResultsM dataCalls = hMap HExceptT dataCalls

runDataCalls :: IO ()
runDataCalls = do
  authToken <- getEnv authTokenEnvName
  print authToken
  manager <- newManager Skroutz.defaultDataManagerSettings
  let dataCallsM :: Data.HList.HList '[ExceptT ServantError IO (Skroutz.WithHeaders Skroutz.MultipleCategoryResponse), ExceptT ServantError IO (Skroutz.WithHeaders Skroutz.SingleCategoryResponse)]
      dataCallsM = makeDataCalls (pack authToken) manager
      dataCallResultsM :: Data.HList.HList '[IO (Either ServantError (Skroutz.WithHeaders Skroutz.MultipleCategoryResponse)), IO (Either ServantError (Skroutz.WithHeaders Skroutz.SingleCategoryResponse))]
      dataCallResultsM = hMap HExceptT dataCallsM --dataCallResultsM dataCalls
      seqDataCallResultsM :: IO (Data.HList.HList '[Either ServantError (Skroutz.WithHeaders Skroutz.MultipleCategoryResponse), Either ServantError (Skroutz.WithHeaders Skroutz.SingleCategoryResponse)])
      seqDataCallResultsM = hSequence dataCallResultsM
  seqDataCallResults <- seqDataCallResultsM
  let errorsJust :: [Maybe ServantError]
      errorsJust = hMapOut HLeftToMaybe seqDataCallResults
  print errorsJust
  let successesJust :: Data.HList.HList '[Maybe (Skroutz.WithHeaders Skroutz.MultipleCategoryResponse), Maybe (Skroutz.WithHeaders Skroutz.SingleCategoryResponse)]
      successesJust = hMap HRightToMaybe seqDataCallResults
      responsesJust :: Data.HList.HList '[Skroutz.MultipleCategoryResponse, Skroutz.SingleCategoryResponse]
      responsesJust = hMap HResponse successesJust
      responsesJustL :: [String]
      responsesJustL = hMapOut HShow responsesJust

  print responsesJustL
  --hMapM_ (HComp HPrint HResponse) successesOnly


runDataCalls2 :: IO ()
runDataCalls2 = do
  authToken <- getEnv authTokenEnvName
  print authToken
  manager <- newManager Skroutz.defaultDataManagerSettings
  let dataCallsM = makeDataCalls (pack authToken) manager
  seqDataCallResults <- hSequence $ hMap HExceptT dataCallsM
  print $ hMapOut HLeftToMaybe seqDataCallResults
  print $ hMapOut HShow $ hMap HResponse $ hMap HRightToMaybe seqDataCallResults
