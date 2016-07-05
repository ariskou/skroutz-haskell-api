{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Types.Manufacturer
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Skroutz API endpoints/methods for 'Web.Skroutz.Types.Manufacturer' retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Types.Manufacturer
where

import           Data.Proxy                         (Proxy (..))
import           GHC.Generics                       (Generic)
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Endpoints.Types.Common
import           Web.Skroutz.Endpoints.Types.Sku    (SkuOrderBy, SkuOrderDir)
import           Web.Skroutz.Types


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

type ManufacturerAPI =
        "manufacturers" :> DataAPIMethod MultipleManufacturerResponse
  :<|>  "manufacturers" :> Capture "manufacturer_id" Int :> DataAPIMethod SingleManufacturerResponse
  :<|>  "manufacturers" :> Capture "category_id" Int :> "categories" :> QueryParam "order_by" ManufacturerOrderBy :> QueryParam "order_dir" ManufacturerOrderDir :> DataAPIMethod MultipleCategoryResponse
  :<|>  "manufacturers" :> Capture "category_id" Int :> "skus" :> QueryParam "order_by" SkuOrderBy :> QueryParam "order_dir" SkuOrderDir :> DataAPIMethod MultipleSkuResponse

manufacturerAPI :: Proxy ManufacturerAPI
manufacturerAPI = Proxy

getManufacturers :: StandardDataParams MultipleManufacturerResponse

getManufacturer :: Int -> StandardDataParams SingleManufacturerResponse

getManufacturerCategories :: Int -> Maybe ManufacturerOrderBy -> Maybe ManufacturerOrderDir -> StandardDataParams MultipleCategoryResponse

getManufacturerSkus :: Int -> Maybe SkuOrderBy -> Maybe SkuOrderDir -> StandardDataParams MultipleSkuResponse

getManufacturers :<|> getManufacturer :<|> getManufacturerCategories :<|> getManufacturerSkus = client manufacturerAPI
