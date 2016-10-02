{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.ApiEntries
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :  non-portable
--
-- Provides a list of API entries to test.
----------------------------------------------------------------------------
module Web.Skroutz.ApiEntries
where

import           Control.Monad.Trans.Except (ExceptT, runExceptT)
import qualified Data.Aeson                 as Aeson
import           Data.ByteString.Lazy       (ByteString)
import           Data.Either.Combinators    (mapRight)
import           Data.Proxy                 (Proxy (..))
import           Data.Text                  (Text)
import           Network.HTTP.Client        (Manager)
import           Servant.Client             (ServantError)
import           Servant.Common.BaseUrl     (BaseUrl)
import qualified Web.Skroutz                as Skroutz

checkWithStdParams :: (Maybe Text -> Maybe Text -> Manager -> BaseUrl -> ExceptT ServantError IO t) -> Text -> Manager -> IO (Either ServantError ())
checkWithStdParams f authToken manager = mapRight (const ()) <$> runExceptT (Skroutz.withStdParams f authToken manager)

checkWithStdParamsPaged :: Maybe Int -> Maybe Int -> (Maybe Int -> Maybe Int -> Maybe Text -> Maybe Text -> Manager -> BaseUrl -> ExceptT ServantError IO t) -> Text -> Manager -> IO (Either ServantError ())
checkWithStdParamsPaged page per f authToken manager = mapRight (const ()) <$> runExceptT (Skroutz.withStdParamsPaged page per f authToken manager)

checkWithStdParamsPagedDefaults :: (Maybe Int -> Maybe Int -> Maybe Text -> Maybe Text -> Manager -> BaseUrl -> ExceptT ServantError IO t) -> Text -> Manager -> IO (Either ServantError ())
checkWithStdParamsPagedDefaults f authToken manager = mapRight (const ()) <$> runExceptT (Skroutz.withStdParamsPagedDefaults f authToken manager)

checkDecode :: forall a. Aeson.FromJSON a => Proxy a -> ByteString -> Either String ()
checkDecode _ str = mapRight (const ()) (Aeson.eitherDecode str :: Either String a)

type ApiEntry = (String, String, Text -> Manager -> IO (Either ServantError ()), ByteString -> Either String ())

apiEntries :: [ApiEntry]
apiEntries = [
    ("categories_index", "http://api.skroutz.gr/categories", checkWithStdParamsPagedDefaults Skroutz.getCategories, checkDecode (Proxy :: Proxy Skroutz.MultipleCategoryResponse))
  , ("categories_root", "http://api.skroutz.gr/categories/root", checkWithStdParams Skroutz.getCategoryRoot, checkDecode (Proxy :: Proxy Skroutz.SingleCategoryResponse))
  , ("categories_show", "http://api.skroutz.gr/categories/1442", checkWithStdParams $ Skroutz.getCategory 1442, checkDecode (Proxy :: Proxy Skroutz.SingleCategoryResponse))
  , ("children_api_category", "http://api.skroutz.gr/categories/1434/children", checkWithStdParamsPagedDefaults $ Skroutz.getCategoryChildren 1434, checkDecode (Proxy :: Proxy Skroutz.MultipleCategoryResponse)) -- is 73 in the docs, but that category does not exist
  , ("category_manufacturers", "http://api.skroutz.gr/categories/25/manufacturers", checkWithStdParamsPagedDefaults $ Skroutz.getCategoryManufacturers 25 Nothing Nothing, checkDecode (Proxy :: Proxy Skroutz.MultipleManufacturerResponse))
  , ("category_skus", "http://api.skroutz.gr/categories/40/skus", checkWithStdParamsPagedDefaults $ Skroutz.getCategorySkus 40 Nothing Nothing [] Nothing [] [] Nothing, checkDecode (Proxy :: Proxy Skroutz.MultipleSkuResponse))
  , ("category_parent", "http://api.skroutz.gr/categories/1442/parent", checkWithStdParams $ Skroutz.getCategoryParent 1442, checkDecode (Proxy :: Proxy Skroutz.SingleCategoryResponse))
  , ("shops_show", "http://api.skroutz.gr/shops/452", checkWithStdParams $ Skroutz.getShop 452, checkDecode (Proxy :: Proxy Skroutz.SingleShopResponse))
  , ("shop_locations_index", "http://api.skroutz.gr/shops/452/locations", checkWithStdParamsPagedDefaults $ Skroutz.getShopLocations 452 Nothing, checkDecode (Proxy :: Proxy Skroutz.MultipleShopLocationResponse))
  , ("shop_locations_index_embed_address", "http://api.skroutz.gr/shops/452/locations?embed=address", checkWithStdParamsPagedDefaults $ Skroutz.getShopLocations 452 (Just Skroutz.ShopLocationEmbedAddress), checkDecode (Proxy :: Proxy Skroutz.MultipleShopLocationResponse))
  , ("shop_locations_show", "http://api.skroutz.gr/shops/452/locations/2500", checkWithStdParams $ Skroutz.getShopLocation 452 2500 Nothing, checkDecode (Proxy :: Proxy Skroutz.SingleShopLocationResponse))
  , ("shop_locations_show_embed_address", "http://api.skroutz.gr/shops/452/locations/2500?embed=address", checkWithStdParams $ Skroutz.getShopLocation 452 2500 (Just Skroutz.ShopLocationEmbedAddress), checkDecode (Proxy :: Proxy Skroutz.SingleShopLocationResponse))
  , ("manufacturers_show", "http://api.skroutz.gr/manufacturers/12907", checkWithStdParams $ Skroutz.getManufacturer 12907, checkDecode (Proxy :: Proxy Skroutz.SingleManufacturerResponse))
  , ("manufacturers_index", "http://api.skroutz.gr/manufacturers", checkWithStdParamsPagedDefaults Skroutz.getManufacturers, checkDecode (Proxy :: Proxy Skroutz.MultipleManufacturerResponse))
  , ("manufacturer_categories", "http://api.skroutz.gr/manufacturers/356/categories", checkWithStdParamsPagedDefaults $ Skroutz.getManufacturerCategories 356 Nothing Nothing, checkDecode (Proxy :: Proxy Skroutz.MultipleCategoryResponse))
  , ("manufacturer_skus", "http://api.skroutz.gr/manufacturers/356/skus", checkWithStdParamsPagedDefaults $ Skroutz.getManufacturerSkus 356 Nothing Nothing, checkDecode (Proxy :: Proxy Skroutz.MultipleSkuResponse))
  , ("autocomplete", "http://api.skroutz.gr/autocomplete?q=iph", checkWithStdParams $ Skroutz.getAutocompletes (Just "iph"), checkDecode (Proxy :: Proxy Skroutz.MultipleAutocompleteResponse))
  , ("search_category_match", "http://api.skroutz.gr/search?q=Tablets", checkWithStdParamsPagedDefaults $ Skroutz.getGeneralSearchResult (Just "Tablets"), checkDecode (Proxy :: Proxy Skroutz.MultipleGeneralSearchResultResponse))
  , ("search_manufacturer_match", "http://api.skroutz.gr/search?q=apple", checkWithStdParamsPagedDefaults $ Skroutz.getGeneralSearchResult (Just "apple"), checkDecode (Proxy :: Proxy Skroutz.MultipleGeneralSearchResultResponse))
  , ("search_latin_mapping", "http://api.skroutz.gr/search?q=ιπηονε", checkWithStdParamsPagedDefaults $ Skroutz.getGeneralSearchResult (Just "ιπηονε"), checkDecode (Proxy :: Proxy Skroutz.MultipleGeneralSearchResultResponse))
  , ("search_spelling", "http://api.skroutz.gr/search?q=ipone", checkWithStdParamsPagedDefaults $ Skroutz.getGeneralSearchResult (Just "ipone"), checkDecode (Proxy :: Proxy Skroutz.MultipleGeneralSearchResultResponse))
  , ("search_drop", "http://api.skroutz.gr/search?q=wrong+iphone", checkWithStdParamsPagedDefaults $ Skroutz.getGeneralSearchResult (Just "wrong iphone"), checkDecode (Proxy :: Proxy Skroutz.MultipleGeneralSearchResultResponse))
  , ("search_no_results", "http://api.skroutz.gr/search?q=asdf", checkWithStdParamsPagedDefaults $ Skroutz.getGeneralSearchResult (Just "asdf"), checkDecode (Proxy :: Proxy Skroutz.MultipleGeneralSearchResultResponse))
  , ("search_category_facade", "http://api.skroutz.gr/search?q=iphone", checkWithStdParamsPagedDefaults $ Skroutz.getGeneralSearchResult (Just "iphone"), checkDecode (Proxy :: Proxy Skroutz.MultipleGeneralSearchResultResponse))
  , ("search_sku_match", "http://api.skroutz.gr/search?q=nikon+1+j2", checkWithStdParamsPagedDefaults $ Skroutz.getGeneralSearchResult (Just "nikon 1 j2"), checkDecode (Proxy :: Proxy Skroutz.MultipleGeneralSearchResultResponse))
  , ("search_skus_match", "http://api.skroutz.gr/search?q=samsung+galaxy+s5+16GB", checkWithStdParamsPagedDefaults $ Skroutz.getGeneralSearchResult (Just "samsung galaxy s5 16GB"), checkDecode (Proxy :: Proxy Skroutz.MultipleGeneralSearchResultResponse))
  , ("skus_show", "http://api.skroutz.gr/skus/3690169", checkWithStdParams $ Skroutz.getSku 3690169 Nothing, checkDecode (Proxy :: Proxy Skroutz.SingleSkuResponse))
  , ("skus_reviews", "http://api.skroutz.gr/skus/3690169/reviews", checkWithStdParamsPagedDefaults $ Skroutz.getSkuReviews 3690169 Nothing, checkDecode (Proxy :: Proxy Skroutz.MultipleSkuReviewResponse))
  , ("skus_products", "http://api.skroutz.gr/skus/3783654/products", checkWithStdParamsPagedDefaults $ Skroutz.getSkuProducts 3783654 Nothing, checkDecode (Proxy :: Proxy Skroutz.MultipleProductResponse))
  , ("skus_similar", "http://api.skroutz.gr/skus/3034682/similar", checkWithStdParamsPagedDefaults $ Skroutz.getSimilarSkus 3034682 Nothing, checkDecode (Proxy :: Proxy Skroutz.MultipleSkuResponse))
  , ("skus_price_history", "http://api.skroutz.gr/skus/3034682/price_history", checkWithStdParams $ Skroutz.getSkuPriceHistory 3034682 Nothing, checkDecode (Proxy :: Proxy Skroutz.HistoricalSkuPriceResponse))
  , ("products_show", "http://api.skroutz.gr/products/12176638", checkWithStdParams $ Skroutz.getProduct 12176638, checkDecode (Proxy :: Proxy Skroutz.SingleProductResponse))
  , ("products_search", "http://api.skroutz.gr/shops/452/products/search?shop_uid=95F", checkWithStdParamsPagedDefaults $ Skroutz.getShopProducts 452 (Just "95F"), checkDecode (Proxy :: Proxy Skroutz.MultipleProductResponse))
  , ("filter_groups_index", "http://api.skroutz.gr/categories/40/filter_groups", checkWithStdParamsPagedDefaults $ Skroutz.getFilterGroups 40, checkDecode (Proxy :: Proxy Skroutz.MultipleFilterGroupResponse))
  , ("category_skus_search", "http://api.skroutz.gr/categories/40/skus?q=iphone", checkWithStdParamsPagedDefaults $ Skroutz.getCategorySkus 40 Nothing Nothing [] (Just "iphone") [] [] Nothing, checkDecode (Proxy :: Proxy Skroutz.MultipleSkuResponse))
  , ("category_skus_manufacturers", "http://api.skroutz.gr/categories/40/skus?manufacturer_ids%5B%5D=28&manufacturer_ids%5B%5D=2", checkWithStdParamsPagedDefaults $ Skroutz.getCategorySkus 40 Nothing Nothing [] Nothing [28, 2] [] Nothing, checkDecode (Proxy :: Proxy Skroutz.MultipleSkuResponse))
  , ("category_skus_filters", "http://api.skroutz.gr/categories/40/skus?filter_ids%5B%5D=355559&filter_ids%5B%5D=6282", checkWithStdParamsPagedDefaults $ Skroutz.getCategorySkus 40 Nothing Nothing [] Nothing [] [355559, 6282] Nothing, checkDecode (Proxy :: Proxy Skroutz.MultipleSkuResponse))
  , ("category_skus_with_available_filters", "http://api.skroutz.gr/categories/279/skus?include_meta=available_filters", checkWithStdParamsPagedDefaults $ Skroutz.getCategorySkus 279 Nothing Nothing [Skroutz.SkuIncludeMetaAvailableFilters] Nothing [] [] Nothing, checkDecode (Proxy :: Proxy Skroutz.MultipleSkuResponse))
  , ("category_skus_with_applied_filters", "http://api.skroutz.gr/categories/40/skus?include_meta=applied_filters&filter_ids%5B%5D=6282&manufacturer_ids%5B%5D=28", checkWithStdParamsPagedDefaults $ Skroutz.getCategorySkus 40 Nothing Nothing [Skroutz.SkuIncludeMetaAppliedFilters] Nothing [28] [6282] Nothing, checkDecode (Proxy :: Proxy Skroutz.MultipleSkuResponse))
  , ("sku_reviews", "http://api.skroutz.gr/skus/355766/reviews", checkWithStdParamsPagedDefaults $ Skroutz.getSkuReviews 355766 Nothing, checkDecode (Proxy :: Proxy Skroutz.MultipleSkuReviewResponse))
  , ("sku_specifications", "http://api.skroutz.gr/skus/2588170/specifications", checkWithStdParams $ Skroutz.getSkuSpecifications 2588170 Nothing Nothing, checkDecode (Proxy :: Proxy Skroutz.MultipleSkuSpecificationResponse))
  , ("sku_specifications_include_group", "http://api.skroutz.gr/skus/2588170/specifications?include=group", checkWithStdParams $ Skroutz.getSkuSpecifications 2588170 (Just Skroutz.SkuSpecificationIncludeGroup) Nothing, checkDecode (Proxy :: Proxy Skroutz.MultipleSkuSpecificationResponse))
  , ("shop_reviews", "http://api.skroutz.gr/shops/452/reviews", checkWithStdParamsPagedDefaults $ Skroutz.getShopReviews 452, checkDecode (Proxy :: Proxy Skroutz.MultipleShopReviewResponse)) -- is 3 in the docs, but that shop has no reviews
  , ("shop_search", "http://api.skroutz.gr/shops/search?q=spartoo", checkWithStdParamsPagedDefaults $ Skroutz.getShops (Just "spartoo"), checkDecode (Proxy :: Proxy Skroutz.MultipleShopResponse))
  , ("flags_index", "http://api.skroutz.gr/flags", checkWithStdParams Skroutz.getFlags, checkDecode (Proxy :: Proxy Skroutz.MultipleFlagResponse))
  ]
