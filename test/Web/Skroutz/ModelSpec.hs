{-# LANGUAGE ExplicitForAll      #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.ModelSpec
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Hspec tests for the types in 'Web.Skroutz.Model'.
----------------------------------------------------------------------------
module Web.Skroutz.ModelSpec
(
    main
  , spec
)
where

import qualified Data.Aeson           as Aeson
import           Data.ByteString.Lazy (ByteString, readFile)
import           Data.Either          (isRight)
import           Data.Proxy           (Proxy (..))
import           System.Directory     (getCurrentDirectory)
import           System.FilePath      ((</>))
import           Test.Hspec           (Spec, SpecWith, describe, hspec, it,
                                       shouldSatisfy)
import qualified Web.Skroutz          as Skroutz

readJSON :: FilePath -> FilePath -> IO ByteString
readJSON category result = do
  dir <- getCurrentDirectory
  Data.ByteString.Lazy.readFile (dir </> "test" </> "fixtures" </> category </> (result ++ ".json"))

genericSpec :: forall a . (Show a, Aeson.FromJSON a) => Proxy a -> String -> FilePath -> FilePath -> SpecWith ()
genericSpec _ description fixtureDir fixtureFilename =
  it description $ do
    resp <- readJSON fixtureDir fixtureFilename
    (Aeson.eitherDecode resp :: Either String a) `shouldSatisfy` isRight

spec :: Spec
spec =
  describe "JSON Parsing" $ do
    genericSpec (Proxy :: Proxy Skroutz.SingleCategoryResponse) "parses a single Category" "category" "successful_one_response_body.json.formatted"
    genericSpec (Proxy :: Proxy Skroutz.MultipleCategoryResponse) "parses a list of Category" "category" "successful_all_response_body.json.formatted"

    genericSpec (Proxy :: Proxy Skroutz.SingleManufacturerResponse) "parses a single Manufacturer" "manufacturer" "successful_one_response_body.json.formatted"
    genericSpec (Proxy :: Proxy Skroutz.MultipleManufacturerResponse) "parses a list of Manufacturer" "manufacturer" "successful_all_response_body.json.formatted"

    genericSpec (Proxy :: Proxy Skroutz.SingleProductResponse) "parses a single Product" "product" "successful_one_response_body.json.formatted"
    genericSpec (Proxy :: Proxy Skroutz.MultipleProductResponse) "parses a list of Product" "product" "successful_search_response_body.json.formatted"
    genericSpec (Proxy :: Proxy Skroutz.MultipleProductResponse) "parses an empty list of Product" "product" "no_results_response_body.json.formatted"

    genericSpec (Proxy :: Proxy Skroutz.SingleShopResponse) "parses a single Shop" "shop" "successful_one_response_body.json.formatted"
    genericSpec (Proxy :: Proxy Skroutz.MultipleShopResponse) "parses a list of Shop" "shop" "successful_search_response_body.json.formatted"
    genericSpec (Proxy :: Proxy Skroutz.MultipleShopResponse) "parses an empty list of Shop" "shop" "no_results_response_body.json.formatted"

    genericSpec (Proxy :: Proxy Skroutz.SingleShopLocationResponse) "parses a single ShopLocation" "shop" "successful_one_location_one_response_body.json.formatted"
    genericSpec (Proxy :: Proxy Skroutz.MultipleShopLocationResponse) "parses a list of ShopLocation" "shop" "successful_one_locations_response_body.json.formatted"
    genericSpec (Proxy :: Proxy Skroutz.MultipleShopLocationResponse) "parses a list of ShopLocation" "shop" "successful_one_locations_embed_address_response_body.json.formatted"

    genericSpec (Proxy :: Proxy Skroutz.MultipleShopReviewResponse) "parses a list of ShopReview" "shop" "successful_one_reviews_response_body.json.formatted"

main :: IO ()
main = hspec spec
