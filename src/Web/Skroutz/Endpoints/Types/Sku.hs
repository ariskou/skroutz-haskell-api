{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE FlexibleInstances #-}
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
-- Provides the Skroutz API endpoints/methods for 'Web.Skroutz.Types.Base.Sku' retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Types.Sku
where

import           Data.Proxy                         (Proxy (..))
import           Data.Text                          (Text, intercalate)
import           GHC.Generics                       (Generic)
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Endpoints.Types.Common
import           Web.Skroutz.Types

data SkuEmbed = SkuEmbedProducts | SkuEmbedManufacturer
 deriving (Generic, Show)

instance ToHttpApiData SkuEmbed where
  toQueryParam SkuEmbedProducts = "products"
  toQueryParam SkuEmbedManufacturer = "manufacturer"

instance ToHttpApiData [SkuEmbed] where
  toQueryParam xs = intercalate "," $ fmap toQueryParam xs

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
  :> QueryParam "embed" [SkuEmbed]
  :> DataAPIMethodPaged MultipleSkuResponse

type SkuAPI =
        SkuSearchAPI
  :<|>  "skus" :> Capture "sku_id" Int :> QueryParam "embed" [SkuEmbed] :> DataAPIMethod SingleSkuResponse
  :<|>  "skus" :> Capture "sku_id" Int :> "similar" :> QueryParam "embed" [SkuEmbed] :> DataAPIMethodPaged MultipleSkuResponse
  :<|>  "skus" :> Capture "sku_id" Int :> "products" :> QueryParam "embed" [SkuEmbed] :> DataAPIMethodPaged MultipleProductResponse
  :<|>  "skus" :> Capture "sku_id" Int :> "reviews" :> QueryParam "embed" [SkuEmbed] :> DataAPIMethodPaged MultipleSkuReviewResponse
  :<|>  "skus" :> Capture "sku_id" Int :> "specifications" :> QueryParam "include" SkuSpecificationInclude :> QueryParam "embed" [SkuEmbed] :> DataAPIMethod MultipleSkuSpecificationResponse
  :<|>  "skus" :> Capture "sku_id" Int :> "price_history" :> QueryParam "embed" [SkuEmbed] :> DataAPIMethod HistoricalSkuPriceResponse

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
  -> Maybe [SkuEmbed]
  -> StandardDataParamsPaged MultipleSkuResponse

getSku :: Int -> Maybe [SkuEmbed] -> StandardDataParams SingleSkuResponse

getSimilarSkus :: Int -> Maybe [SkuEmbed] -> StandardDataParamsPaged MultipleSkuResponse

getSkuProducts :: Int -> Maybe [SkuEmbed] -> StandardDataParamsPaged MultipleProductResponse

getSkuReviews :: Int -> Maybe [SkuEmbed] -> StandardDataParamsPaged MultipleSkuReviewResponse

getSkuSpecifications :: Int -> Maybe SkuSpecificationInclude -> Maybe [SkuEmbed] -> StandardDataParams MultipleSkuSpecificationResponse

getSkuPriceHistory :: Int -> Maybe [SkuEmbed] -> StandardDataParams HistoricalSkuPriceResponse

getCategorySkus :<|> getSku :<|> getSimilarSkus :<|> getSkuProducts :<|> getSkuReviews :<|> getSkuSpecifications :<|> getSkuPriceHistory = client skuAPI
