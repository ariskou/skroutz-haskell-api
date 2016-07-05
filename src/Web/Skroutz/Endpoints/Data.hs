{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
{-# LANGUAGE DeriveGeneric   #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Data
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Skroutz API endpoints/methods for normal data retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Data
where

import           Control.Monad.Trans.Except (ExceptT)
import           Data.Monoid                ((<>))
import           Data.Proxy                 (Proxy (..))
import           Data.Text                  (Text)
import           GHC.Generics               (Generic)
import           Network.HTTP.Client        (Manager, ManagerSettings,
                                             defaultManagerSettings)
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Types

type WithHeaders a = Headers '[
    Header "X-RateLimit-Limit" Int
  , Header "X-RateLimit-Remaining" Int
  , Header "X-RateLimit-Reset" Int
  , Header "Content-Type" Text
  , Header "Vary" Text
  , Header "X-Frame-Options" Text
  , Header "X-XSS-Protection" Text
  , Header "X-Content-Type-Options" Text
  , Header "Link" Text
  , Header "Cache-Control" Text
  , Header "ETag" Text
  , Header "X-Request-Id" Text
  , Header "X-DNS-Prefetch-Control" Text
  , Header "Access-Control-Allow-Origin" Text
  , Header "Access-Control-Allow-Methods" Text
  , Header "Content-Length" Text
  , Header "Accept-Ranges" Text
  , Header "Date" Text
  , Header "Age" Text
  , Header "X-Cache" Text
  ] a

type AcceptHeader = Header "Accept" Text

type AuthorizationHeader = Header "Authorization" Text

type DataAPIMethod a =
  AcceptHeader
  :> AuthorizationHeader
  :> Get '[JSON] (WithHeaders a)

data ManufacturerOrderBy = ManufacturerOrderByName | ManufacturerOrderByPopularity
 deriving (Generic, Show)

instance ToHttpApiData ManufacturerOrderBy where
  toQueryParam ManufacturerOrderByName = "name"
  toQueryParam ManufacturerOrderByPopularity = "popularity"

data ManufacturerOrderDir = ManufacturerOrderDirAscending | ManufacturerOrderDirDescending
 deriving (Generic, Show)

instance ToHttpApiData ManufacturerOrderDir where
  toQueryParam ManufacturerOrderDirAscending = "asc"
  toQueryParam ManufacturerOrderDirDescending = "desc"

type DataAPI =
        "categories" :> DataAPIMethod MultipleCategoryResponse
  :<|>  "categories" :> Capture "category_id" Int :> DataAPIMethod Category
  :<|>  "categories" :> Capture "category_id" Int :> "parent" :> DataAPIMethod Category
  :<|>  "categories" :> "root" :> DataAPIMethod Category
  :<|>  "categories" :> Capture "category_id" Int :> "children" :> DataAPIMethod MultipleCategoryResponse
  :<|>  "categories" :> Capture "category_id" Int :> "manufacturers" :> QueryParam "order_by" ManufacturerOrderBy :> QueryParam "order_dir" ManufacturerOrderDir :> DataAPIMethod MultipleManufacturerResponse

dataAPI :: Proxy DataAPI
dataAPI = Proxy

type StandardParams a = Maybe Text -> Maybe Text -> Manager -> BaseUrl -> ExceptT ServantError IO (WithHeaders a)

getCategories :: StandardParams MultipleCategoryResponse

getCategory :: Int -> StandardParams Category

getCategoryParent :: Int -> StandardParams Category

getCategoryRoot :: StandardParams Category

getCategoryChildren :: Int -> StandardParams MultipleCategoryResponse

getCategoryManufacturers :: Int -> Maybe ManufacturerOrderBy -> Maybe ManufacturerOrderDir -> StandardParams MultipleManufacturerResponse

getCategories :<|> getCategory :<|> getCategoryParent :<|> getCategoryRoot :<|> getCategoryChildren :<|> getCategoryManufacturers = client dataAPI

defaultDataManagerSettings :: ManagerSettings
defaultDataManagerSettings = defaultManagerSettings

defaultDataBaseUrl :: BaseUrl
defaultDataBaseUrl = BaseUrl Http "api.skroutz.gr" 80 ""

defaultDataAcceptHeader :: Text
defaultDataAcceptHeader = "application/vnd.skroutz+json; version=3"

makeAuthToken :: Text -> Text
makeAuthToken token = "Bearer " <> token
