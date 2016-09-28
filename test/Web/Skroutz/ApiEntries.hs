{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.ApiEntries
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides a list of API entries to test.
----------------------------------------------------------------------------
module Web.Skroutz.ApiEntries
where

import           Data.HList             (HList (HNil), (.*.))
import           Data.Proxy             (Proxy (..))
import           Data.Text              (Text)
import           Network.HTTP.Client    (Manager)
import           Servant.Common.BaseUrl (BaseUrl)
import qualified Web.Skroutz            as Skroutz

withStdParams :: (Maybe Text -> Maybe Text -> Manager -> BaseUrl -> t) -> Text -> Manager -> t
withStdParams f authToken manager = f (Just Skroutz.defaultDataAcceptHeader) (Just $ Skroutz.makeAuthToken authToken) manager Skroutz.defaultDataBaseUrl

withStdParamsPaged :: Maybe Int -> Maybe Int -> (Maybe Int -> Maybe Int -> Maybe Text -> Maybe Text -> Manager -> BaseUrl -> t) -> Text -> Manager -> t
withStdParamsPaged page per f authToken manager = f page per (Just Skroutz.defaultDataAcceptHeader) (Just $ Skroutz.makeAuthToken authToken) manager Skroutz.defaultDataBaseUrl

withStdParamsPagedDefaults :: (Maybe Int -> Maybe Int -> Maybe Text -> Maybe Text -> Manager -> BaseUrl -> t) -> Text -> Manager -> t
withStdParamsPagedDefaults = withStdParamsPaged (Just 1) (Just 25)

apiEntries =
      ("categories_index" :: String, "/categories" :: String, withStdParamsPagedDefaults Skroutz.getCategories, Proxy :: Proxy Skroutz.MultipleCategoryResponse)
  .*. ("categories_root" :: String, "/categories/root" :: String, withStdParams Skroutz.getCategoryRoot, Proxy :: Proxy Skroutz.SingleCategoryResponse)
  .*. ("categories_show" :: String, "/categories/1442" :: String, withStdParams $ Skroutz.getCategory 1442, Proxy :: Proxy Skroutz.SingleCategoryResponse)
  .*. ("children_api_category" :: String, "/categories/1434/children" :: String, withStdParamsPagedDefaults $ Skroutz.getCategoryChildren 1434, Proxy :: Proxy Skroutz.MultipleCategoryResponse) -- is 73 in the docs, but that category does not exist
  .*. ("category_manufacturers" :: String, "/categories/25/manufacturers" :: String, withStdParamsPagedDefaults $ Skroutz.getCategoryManufacturers 25 Nothing Nothing, Proxy :: Proxy Skroutz.MultipleManufacturerResponse)
  .*. ("category_skus" :: String, "/categories/40/skus" :: String, withStdParamsPagedDefaults $ Skroutz.getCategorySkus 40 Nothing Nothing [] Nothing [] [] Nothing, Proxy :: Proxy Skroutz.MultipleSkuResponse)
  .*. ("category_parent" :: String, "/categories/1442/parent" :: String, withStdParams $ Skroutz.getCategoryParent 1442, Proxy :: Proxy Skroutz.SingleCategoryResponse)
  .*. ("shops_show" :: String, "/shops/452" :: String, withStdParams $ Skroutz.getShop 452, Proxy :: Proxy Skroutz.SingleShopResponse)
  .*. ("shop_locations_index" :: String, "/shops/452/locations" :: String, withStdParamsPagedDefaults $ Skroutz.getShopLocations 452 Nothing, Proxy :: Proxy Skroutz.MultipleShopLocationResponse)
  .*. ("shop_locations_index_embed_address" :: String, "/shops/452/locations?embed=address" :: String, withStdParamsPagedDefaults $ Skroutz.getShopLocations 452 (Just Skroutz.ShopLocationEmbedAddress), Proxy :: Proxy Skroutz.MultipleShopLocationResponse)
  .*. ("shop_locations_show" :: String, "/shops/452/locations/2500" :: String, withStdParams $ Skroutz.getShopLocation 452 2500 Nothing, Proxy :: Proxy Skroutz.SingleShopLocationResponse)
  .*. ("shop_locations_show_embed_address" :: String, "/shops/452/locations/2500?embed=address" :: String, withStdParams $ Skroutz.getShopLocation 452 2500 (Just Skroutz.ShopLocationEmbedAddress), Proxy :: Proxy Skroutz.SingleShopLocationResponse)
  .*. ("manufacturers_show" :: String, "/manufacturers/12907" :: String, withStdParams $ Skroutz.getManufacturer 12907, Proxy :: Proxy Skroutz.SingleManufacturerResponse)
  .*. ("manufacturers_index" :: String, "/manufacturers" :: String, withStdParamsPagedDefaults Skroutz.getManufacturers, Proxy :: Proxy Skroutz.MultipleManufacturerResponse)
  .*. ("manufacturer_categories" :: String, "/manufacturers/356/categories" :: String, withStdParamsPagedDefaults $ Skroutz.getManufacturerCategories 356 Nothing Nothing, Proxy :: Proxy Skroutz.MultipleCategoryResponse)
  .*. ("manufacturer_skus" :: String, "/manufacturers/356/skus" :: String, withStdParamsPagedDefaults $ Skroutz.getManufacturerSkus 356 Nothing Nothing, Proxy :: Proxy Skroutz.MultipleSkuResponse)
  .*. ("autocomplete" :: String, "/autocomplete?q=iph" :: String, withStdParams $ Skroutz.getAutocompletes "iph", Proxy :: Proxy Skroutz.MultipleAutocompleteResponse)
  .*. ("search_category_match" :: String, "/search?q=Tablets" :: String, withStdParamsPagedDefaults $ Skroutz.getGeneralSearchResult "Tablets", Proxy :: Proxy Skroutz.MultipleGeneralSearchResultResponse)
  .*. ("search_manufacturer_match" :: String, "/search?q=apple" :: String, withStdParamsPagedDefaults $ Skroutz.getGeneralSearchResult "apple", Proxy :: Proxy Skroutz.MultipleGeneralSearchResultResponse)
  .*. ("search_latin_mapping" :: String, "/search?q=ιπηονε" :: String, withStdParamsPagedDefaults $ Skroutz.getGeneralSearchResult "ιπηονε", Proxy :: Proxy Skroutz.MultipleGeneralSearchResultResponse)
  .*. ("search_spelling" :: String, "/search?q=ipone" :: String, withStdParamsPagedDefaults $ Skroutz.getGeneralSearchResult "ipone", Proxy :: Proxy Skroutz.MultipleGeneralSearchResultResponse)
  .*. ("search_drop" :: String, "/search?q=wrong+iphone" :: String, withStdParamsPagedDefaults $ Skroutz.getGeneralSearchResult "wrong iphone", Proxy :: Proxy Skroutz.MultipleGeneralSearchResultResponse)
  .*. ("search_no_results" :: String, "/search?q=asdf" :: String, withStdParamsPagedDefaults $ Skroutz.getGeneralSearchResult "asdf", Proxy :: Proxy Skroutz.MultipleGeneralSearchResultResponse)
  .*. ("search_category_facade" :: String, "/search?q=iphone" :: String, withStdParamsPagedDefaults $ Skroutz.getGeneralSearchResult "iphone", Proxy :: Proxy Skroutz.MultipleGeneralSearchResultResponse)
  .*. ("search_sku_match" :: String, "/search?q=nikon+1+j2" :: String, withStdParamsPagedDefaults $ Skroutz.getGeneralSearchResult "nikon 1 j2", Proxy :: Proxy Skroutz.MultipleGeneralSearchResultResponse)
  .*. ("search_skus_match" :: String, "/search?q=samsung+galaxy+s5+16GB" :: String, withStdParamsPagedDefaults $ Skroutz.getGeneralSearchResult "samsung galaxy s5 16GB", Proxy :: Proxy Skroutz.MultipleGeneralSearchResultResponse)
  .*. ("skus_show" :: String, "/skus/3690169" :: String, withStdParams $ Skroutz.getSku 3690169 Nothing, Proxy :: Proxy Skroutz.SingleSkuResponse)
  .*. ("skus_reviews" :: String, "/skus/3690169/reviews" :: String, withStdParamsPagedDefaults $ Skroutz.getSkuReviews 3690169 Nothing, Proxy :: Proxy Skroutz.MultipleSkuReviewResponse)
  .*. ("skus_products" :: String, "/skus/3783654/products" :: String, withStdParamsPagedDefaults $ Skroutz.getSkuProducts 3783654 Nothing, Proxy :: Proxy Skroutz.MultipleProductResponse)
  .*. ("skus_similar" :: String, "/skus/3034682/similar" :: String, withStdParamsPagedDefaults $ Skroutz.getSimilarSkus 3034682 Nothing, Proxy :: Proxy Skroutz.MultipleSkuResponse)
  .*. ("skus_price_history" :: String, "/skus/3034682/price_history" :: String, withStdParams $ Skroutz.getSkuPriceHistory 3034682 Nothing, Proxy :: Proxy Skroutz.HistoricalSkuPriceResponse)
  .*. ("products_show" :: String, "/products/12176638" :: String, withStdParams $ Skroutz.getProduct 12176638, Proxy :: Proxy Skroutz.SingleProductResponse)
  .*. ("products_search" :: String, "/shops/452/products/search?shop_uid=95F" :: String, withStdParamsPagedDefaults $ Skroutz.getShopProducts 452 (Just "95F"), Proxy :: Proxy Skroutz.MultipleProductResponse)
  .*. ("filter_groups_index" :: String, "/categories/40/filter_groups" :: String, withStdParamsPagedDefaults $ Skroutz.getFilterGroups 40, Proxy :: Proxy Skroutz.MultipleFilterGroupResponse)
  .*. ("category_skus_search" :: String, "/categories/40/skus?q=iphone" :: String, withStdParamsPagedDefaults $ Skroutz.getCategorySkus 40 Nothing Nothing [] (Just "iphone") [] [] Nothing, Proxy :: Proxy Skroutz.MultipleSkuResponse)
  .*. ("category_skus_manufacturers" :: String, "/categories/40/skus?manufacturer_ids%5B%5D=28&manufacturer_ids%5B%5D=2" :: String, withStdParamsPagedDefaults $ Skroutz.getCategorySkus 40 Nothing Nothing [] Nothing [28, 2] [] Nothing, Proxy :: Proxy Skroutz.MultipleSkuResponse)
  .*. ("category_skus_filters" :: String, "/categories/40/skus?filter_ids%5B%5D=355559&filter_ids%5B%5D=6282" :: String, withStdParamsPagedDefaults $ Skroutz.getCategorySkus 40 Nothing Nothing [] Nothing [] [355559, 6282] Nothing, Proxy :: Proxy Skroutz.MultipleSkuResponse)
  .*. ("category_skus_with_available_filters" :: String, "/categories/279/skus?include_meta=available_filters" :: String, withStdParamsPagedDefaults $ Skroutz.getCategorySkus 279 Nothing Nothing [Skroutz.SkuIncludeMetaAvailableFilters] Nothing [] [] Nothing, Proxy :: Proxy Skroutz.MultipleSkuResponse)
  .*. ("category_skus_with_applied_filters" :: String, "/categories/40/skus?include_meta=applied_filters&filter_ids%5B%5D=6282&manufacturer_ids%5B%5D=28" :: String, withStdParamsPagedDefaults $ Skroutz.getCategorySkus 40 Nothing Nothing [Skroutz.SkuIncludeMetaAppliedFilters] Nothing [28] [6282] Nothing, Proxy :: Proxy Skroutz.MultipleSkuResponse)
  .*. ("sku_reviews" :: String, "/skus/355766/reviews" :: String, withStdParamsPagedDefaults $ Skroutz.getSkuReviews 355766 Nothing, Proxy :: Proxy Skroutz.MultipleSkuReviewResponse)
  .*. ("sku_specifications" :: String, "/skus/2588170/specifications" :: String, withStdParams $ Skroutz.getSkuSpecifications 2588170 Nothing Nothing, Proxy :: Proxy Skroutz.MultipleSkuSpecificationResponse)
  .*. ("sku_specifications_include_group" :: String, "/skus/2588170/specifications?include=group" :: String, withStdParams $ Skroutz.getSkuSpecifications 2588170 (Just Skroutz.SkuSpecificationIncludeGroup) Nothing, Proxy :: Proxy Skroutz.MultipleSkuSpecificationResponse)
  .*. ("shop_reviews" :: String, "/shops/452/reviews" :: String, withStdParamsPagedDefaults $ Skroutz.getShopReviews 452, Proxy :: Proxy Skroutz.MultipleShopReviewResponse) -- is 3 in the docs, but that shop has no reviews
  .*. ("shop_search" :: String, "/shops/search?q=spartoo" :: String, withStdParamsPagedDefaults $ Skroutz.getShops (Just "spartoo"), Proxy :: Proxy Skroutz.MultipleShopResponse)
  .*. ("flags_index" :: String, "/flags" :: String, withStdParams Skroutz.getFlags, Proxy :: Proxy Skroutz.MultipleFlagResponse)
  .*. HNil
