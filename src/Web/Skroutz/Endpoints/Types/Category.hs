{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Types.Category
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Skroutz API endpoints/methods for 'Web.Skroutz.Types.Category' retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Types.Category
where

import           Data.Proxy                 (Proxy (..))
import           GHC.Generics               (Generic)
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Types
import           Web.Skroutz.Endpoints.Types.Common

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

type CategoryAPI =
        "categories" :> DataAPIMethod MultipleCategoryResponse
  :<|>  "categories" :> Capture "category_id" Int :> DataAPIMethod Category
  :<|>  "categories" :> Capture "category_id" Int :> "parent" :> DataAPIMethod Category
  :<|>  "categories" :> "root" :> DataAPIMethod Category
  :<|>  "categories" :> Capture "category_id" Int :> "children" :> DataAPIMethod MultipleCategoryResponse
  :<|>  "categories" :> Capture "category_id" Int :> "manufacturers" :> QueryParam "order_by" ManufacturerOrderBy :> QueryParam "order_dir" ManufacturerOrderDir :> DataAPIMethod MultipleManufacturerResponse

categoryAPI :: Proxy CategoryAPI
categoryAPI = Proxy

getCategories :: StandardDataParams MultipleCategoryResponse

getCategory :: Int -> StandardDataParams Category

getCategoryParent :: Int -> StandardDataParams Category

getCategoryRoot :: StandardDataParams Category

getCategoryChildren :: Int -> StandardDataParams MultipleCategoryResponse

getCategoryManufacturers :: Int -> Maybe ManufacturerOrderBy -> Maybe ManufacturerOrderDir -> StandardDataParams MultipleManufacturerResponse

getCategories :<|> getCategory :<|> getCategoryParent :<|> getCategoryRoot :<|> getCategoryChildren :<|> getCategoryManufacturers = client categoryAPI
