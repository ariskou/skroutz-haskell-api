{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Types.Sku
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Skroutz API endpoints/methods for 'Web.Skroutz.Types.Sku' retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Types.Sku
where

import           Data.Proxy                         (Proxy (..))
import           Data.Text                          (Text)
import           GHC.Generics                       (Generic)
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Endpoints.Types.Common
import           Web.Skroutz.Types

data SkuOrderBy = SkuOrderByPriceVAT | SkuOrderByPopularity | SkuOrderByRating
 deriving (Generic, Show)

instance ToHttpApiData SkuOrderBy where
  toQueryParam SkuOrderByPriceVAT = "pricevat"
  toQueryParam SkuOrderByPopularity = "popularity"
  toQueryParam SkuOrderByRating = "rating"

data SkuOrderDir = SkuOrderDirAscending | SkuOrderDirDescending
 deriving (Generic, Show)

instance ToHttpApiData SkuOrderDir where
  toQueryParam SkuOrderDirAscending = "asc"
  toQueryParam SkuOrderDirDescending = "desc"

data SkuSpecificationInclude = SkuSpecificationIncludeGroup
 deriving (Generic, Show)

instance ToHttpApiData SkuSpecificationInclude where
  toQueryParam SkuSpecificationIncludeGroup = "group"


data SkuIncludeMeta = SkuIncludeMetaAvailableFilters | SkuIncludeMetaAppliedFilters
 deriving (Generic, Show)

instance ToHttpApiData SkuIncludeMeta where
  toQueryParam SkuIncludeMetaAvailableFilters = "available_filters"
  toQueryParam SkuIncludeMetaAppliedFilters = "applied_filters"

type SkuSearchAPI =
    "categories"
  :> Capture "category_id" Int
  :> "skus"
  :> QueryParam "order_by" SkuOrderBy
  :> QueryParam "order_dir" SkuOrderDir
  :> QueryParams "include_meta[]" SkuIncludeMeta
  :> QueryParam "q" Text
  :> QueryParams "manufacturer_ids[]" Int
  :> QueryParams "filter_ids[]" Int
  :> DataAPIMethod MultipleSkuResponse

type SkuAPI =
        SkuSearchAPI
  :<|>  "skus" :> Capture "sku_id" Int :> DataAPIMethod SingleSkuResponse
  :<|>  "skus" :> Capture "sku_id" Int :> "similar" :> DataAPIMethod MultipleSkuResponse
  :<|>  "skus" :> Capture "sku_id" Int :> "products" :> DataAPIMethod MultipleProductResponse
  :<|>  "skus" :> Capture "sku_id" Int :> "reviews" :> DataAPIMethod MultipleSkuReviewResponse
  :<|>  "skus" :> Capture "sku_id" Int :> "specifications" :> QueryParam "include" SkuSpecificationInclude :> DataAPIMethod MultipleSkuSpecificationResponse
  :<|>  "skus" :> Capture "sku_id" Int :> "price_history" :> DataAPIMethod HistoricalSkuPriceResponse

skuAPI :: Proxy SkuAPI
skuAPI = Proxy

getCategorySkus ::
     Int
  -> Maybe SkuOrderBy
  -> Maybe SkuOrderDir
  -> [SkuIncludeMeta]
  -> Maybe Text
  -> [Int]
  -> [Int]
  -> StandardDataParams MultipleSkuResponse

getSku :: Int -> StandardDataParams SingleSkuResponse

getSimilarSkus :: Int -> StandardDataParams MultipleSkuResponse

getSkuProducts :: Int -> StandardDataParams MultipleProductResponse

getSkuReviews :: Int -> StandardDataParams MultipleSkuReviewResponse

getSkuSpecifications :: Int -> Maybe SkuSpecificationInclude -> StandardDataParams MultipleSkuSpecificationResponse

getSkuPriceHistory :: Int -> StandardDataParams HistoricalSkuPriceResponse

getCategorySkus :<|> getSku :<|> getSimilarSkus :<|> getSkuProducts :<|> getSkuReviews :<|> getSkuSpecifications :<|> getSkuPriceHistory = client skuAPI
