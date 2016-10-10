{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endpoints.Model.Common
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :  non-portable
--
-- Provides common definitions for the Skroutz API endpoints/methods.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Model.Common
where

import           Data.Monoid                  ((<>))
import           Data.Text                    (Text)
import           Network.HTTP.Client          (ManagerSettings, defaultManagerSettings)
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Endpoints.Compat (APIWrapper)

type WithHeaders a = Headers '[
    Header "Accept-Ranges" Text
  , Header "Access-Control-Allow-Methods" Text
  , Header "Access-Control-Allow-Origin" Text
  , Header "Age" Text
  , Header "Cache-Control" Text
  , Header "Cache-Control" Text
  , Header "Content-Encoding" Text
  , Header "Content-Length" Text
  , Header "Content-Type" Text
  , Header "Date" Text
  , Header "ETag" Text
  , Header "Link" Text
  , Header "Transfer-Encoding" Text
  , Header "Vary" Text
  , Header "X-Cache" Text
  , Header "X-Cached" Text
  , Header "X-Content-Type-Options" Text
  , Header "X-DNS-Prefetch-Control" Text
  , Header "X-Frame-Options" Text
  , Header "X-RateLimit-Limit" Int
  , Header "X-RateLimit-Remaining" Int
  , Header "X-RateLimit-Reset" Int
  , Header "X-Request-Id" Text
  , Header "X-XSS-Protection" Text
  ] a

type AcceptHeader = Header "Accept" Text

type AuthorizationHeader = Header "Authorization" Text

type DataAPIMethod a =
  AcceptHeader
  :> AuthorizationHeader
  :> Get '[JSON] (WithHeaders a)

type DataAPIMethodPaged a =
  QueryParam "page" Int
  :> QueryParam "per" Int
  :> DataAPIMethod a

type StandardDataAPIWrapper a = APIWrapper (WithHeaders a)

type StandardDataParams a = Maybe Text -> Maybe Text -> StandardDataAPIWrapper a

type StandardDataParamsPaged a = Maybe Int -> Maybe Int -> Maybe Text -> Maybe Text -> StandardDataAPIWrapper a

defaultDataManagerSettings :: ManagerSettings
defaultDataManagerSettings = defaultManagerSettings

defaultDataBaseUrl :: BaseUrl
defaultDataBaseUrl = BaseUrl Http "api.skroutz.gr" 80 ""

defaultDataAcceptHeader :: Text
defaultDataAcceptHeader = "application/vnd.skroutz+json; version=3"

defaultDataPage :: Int
defaultDataPage = 1

defaultDataPerPageResultCount :: Int
defaultDataPerPageResultCount = 25

makeAuthToken :: Text -> Text
makeAuthToken token = "Bearer " <> token

withStdParams :: StandardDataParams t -> Text -> StandardDataAPIWrapper t
withStdParams f authToken = f (Just defaultDataAcceptHeader) (Just $ makeAuthToken authToken)

withStdParamsPaged :: Maybe Int -> Maybe Int -> StandardDataParamsPaged t -> Text -> StandardDataAPIWrapper t
withStdParamsPaged page per f authToken = f page per (Just defaultDataAcceptHeader) (Just $ makeAuthToken authToken)

withStdParamsPagedDefaults :: StandardDataParamsPaged t -> Text -> StandardDataAPIWrapper t
withStdParamsPagedDefaults = withStdParamsPaged (Just defaultDataPage) (Just defaultDataPerPageResultCount)
