{-# LANGUAGE DataKinds         #-}
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
-- Provides the Skroutz API endpoints/methods for 'Web.Skroutz.Types.Base.Category' retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Types.Category
where

import           Data.Proxy                               (Proxy (..))
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Endpoints.Types.Common
import           Web.Skroutz.Endpoints.Types.Manufacturer (ManufacturerOrderBy,
                                                           ManufacturerOrderDir)
import           Web.Skroutz.Types

type CategoryAPI =
        "categories" :> DataAPIMethodPaged MultipleCategoryResponse
  :<|>  "categories" :> Capture "category_id" Int :> DataAPIMethod SingleCategoryResponse
  :<|>  "categories" :> Capture "category_id" Int :> "parent" :> DataAPIMethod SingleCategoryResponse
  :<|>  "categories" :> "root" :> DataAPIMethod SingleCategoryResponse
  :<|>  "categories" :> Capture "category_id" Int :> "children" :> DataAPIMethodPaged MultipleCategoryResponse
  :<|>  "categories" :> Capture "category_id" Int :> "manufacturers" :> QueryParam "order_by" ManufacturerOrderBy :> QueryParam "order_dir" ManufacturerOrderDir :> DataAPIMethodPaged MultipleManufacturerResponse

categoryAPI :: Proxy CategoryAPI
categoryAPI = Proxy

getCategories :: StandardDataParamsPaged MultipleCategoryResponse

getCategory :: Int -> StandardDataParams SingleCategoryResponse

getCategoryParent :: Int -> StandardDataParams SingleCategoryResponse

getCategoryRoot :: StandardDataParams SingleCategoryResponse

getCategoryChildren :: Int -> StandardDataParamsPaged MultipleCategoryResponse

getCategoryManufacturers :: Int -> Maybe ManufacturerOrderBy -> Maybe ManufacturerOrderDir -> StandardDataParamsPaged MultipleManufacturerResponse

getCategories :<|> getCategory :<|> getCategoryParent :<|> getCategoryRoot :<|> getCategoryChildren :<|> getCategoryManufacturers = client categoryAPI
