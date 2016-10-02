{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Model.Manufacturer
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability : non-portable
--
-- Provides the Skroutz API endpoints/methods for 'Web.Skroutz.Model.Base.Manufacturer' retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Model.Manufacturer
where

import           Data.Proxy                         (Proxy (..))
import           GHC.Generics                       (Generic)
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Endpoints.Model.Common
import           Web.Skroutz.Endpoints.Model.Sku    (SkuOrderBy, SkuOrderDir)
import           Web.Skroutz.Model

data ManufacturerOrderBy = ManufacturerOrderByName | ManufacturerOrderByPopularity
 deriving (Generic, Show)

instance ToHttpApiData ManufacturerOrderBy where
  toQueryParam ManufacturerOrderByName       = "name"
  toQueryParam ManufacturerOrderByPopularity = "popularity"

data ManufacturerOrderDir = ManufacturerOrderDirAscending | ManufacturerOrderDirDescending
 deriving (Generic, Show)

instance ToHttpApiData ManufacturerOrderDir where
  toQueryParam ManufacturerOrderDirAscending  = "asc"
  toQueryParam ManufacturerOrderDirDescending = "desc"

type ManufacturerAPI =
        "manufacturers" :> DataAPIMethodPaged MultipleManufacturerResponse
  :<|>  "manufacturers" :> Capture "manufacturer_id" Int :> DataAPIMethod SingleManufacturerResponse
  :<|>  "manufacturers" :> Capture "manufacturer_id" Int :> "categories" :> QueryParam "order_by" ManufacturerOrderBy :> QueryParam "order_dir" ManufacturerOrderDir :> DataAPIMethodPaged MultipleCategoryResponse
  :<|>  "manufacturers" :> Capture "manufacturer_id" Int :> "skus" :> QueryParam "order_by" SkuOrderBy :> QueryParam "order_dir" SkuOrderDir :> DataAPIMethodPaged MultipleSkuResponse

manufacturerAPI :: Proxy ManufacturerAPI
manufacturerAPI = Proxy

getManufacturers :: StandardDataParamsPaged MultipleManufacturerResponse

getManufacturer :: Int -> StandardDataParams SingleManufacturerResponse

getManufacturerCategories :: Int -> Maybe ManufacturerOrderBy -> Maybe ManufacturerOrderDir -> StandardDataParamsPaged MultipleCategoryResponse

getManufacturerSkus :: Int -> Maybe SkuOrderBy -> Maybe SkuOrderDir -> StandardDataParamsPaged MultipleSkuResponse

getManufacturers :<|> getManufacturer :<|> getManufacturerCategories :<|> getManufacturerSkus = client manufacturerAPI
