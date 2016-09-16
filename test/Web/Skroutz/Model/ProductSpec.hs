{-# LANGUAGE OverloadedStrings #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.ProductSpec
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Hspec tests for the 'Product' type.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ProductSpec
(
    main
  , spec
)
where

import qualified Web.Skroutz        as Skroutz
import           Web.Skroutz.Common

main :: IO ()
main = hspec spec

spec :: Spec
spec =
  describe "JSON Parsing" $ do
    it "parses a single Product" $ do
      resp <- readJSON "product" "successful_one_response_body.json.formatted"
      let item = resp ^?! (_JSON . Skroutz.singleProductResponseProduct) :: Skroutz.Product
      item ^. Skroutz.productId `shouldBe` 12176638
      item ^. Skroutz.productName `shouldBe` "SAMSUNG E1200 ENG"
      item ^. Skroutz.productSkuId `shouldBe` 2119391
      item ^. Skroutz.productShopId `shouldBe` 670
      item ^. Skroutz.productCategoryId `shouldBe` 40
      item ^. Skroutz.productAvailability `shouldBe` "Παράδοση 1 έως 3 ημέρες"
      item ^. Skroutz.productClickUrl `shouldBe` mkUri "https://www.skroutz.gr/products/show/12176638?client_id=pQRXRvomZkCV8yE95iuKqw%3D%3D&from=api"
      item ^. Skroutz.productShopUid `shouldBe` "220004386"
      item ^. Skroutz.productExpenses `shouldBe` Nothing
      item ^. Skroutz.productWebUri `shouldBe` mkUri "https://skroutz.gr/products/show/12176638"
      item ^. Skroutz.productPrice `shouldBe` 16.8


    it "parses a list of Products" $ do
      resp <- readJSON "product" "successful_search_response_body.json.formatted"
      let itemsMultiple = resp ^?! _JSON :: Skroutz.MultipleProductResponse
          items = itemsMultiple ^?! Skroutz.multipleProductResponseProducts
          meta = itemsMultiple ^?! Skroutz.multipleProductResponseMeta
          pagination = meta ^?! Skroutz.metaPagination
          item0 = items ^?! ix 0

      length items `shouldBe` 1

      pagination ^. Skroutz.paginationTotalResults `shouldBe` 1
      pagination ^. Skroutz.paginationTotalPages `shouldBe` 1
      pagination ^. Skroutz.paginationPage `shouldBe` 1
      pagination ^. Skroutz.paginationPer `shouldBe` 25

      item0 ^. Skroutz.productId `shouldBe` 16514043
      item0 ^. Skroutz.productName `shouldBe` "Apple - Macbook Pro Retina MGXA2GR/A (i7-4770HQ/16GB/256 SSD/Intel Iris Pro) (24 άτοκες δόσεις)"
      item0 ^. Skroutz.productSkuId `shouldBe` 5265267
      item0 ^. Skroutz.productShopId `shouldBe` 11
      item0 ^. Skroutz.productCategoryId `shouldBe` 25
      item0 ^. Skroutz.productAvailability `shouldBe` "Παράδοση 1 έως 3 ημέρες"
      item0 ^. Skroutz.productClickUrl `shouldBe` mkUri "https://www.skroutz.gr/products/show/16514043?client_id=pQRXRvomZkCV8yE95iuKqw%3D%3D&from=api"
      item0 ^. Skroutz.productShopUid `shouldBe` "2209985"
      item0 ^. Skroutz.productExpenses `shouldBe` Nothing
      item0 ^. Skroutz.productWebUri `shouldBe` mkUri "https://skroutz.gr/products/show/16514043"
      item0 ^. Skroutz.productPrice `shouldBe` 2449

    it "parses an empty list of Products" $ do
      resp <- readJSON "product" "no_results_response_body.json.formatted"
      let itemsMultiple = resp ^?! _JSON :: Skroutz.MultipleProductResponse
          items = itemsMultiple ^?! Skroutz.multipleProductResponseProducts
          meta = itemsMultiple ^?! Skroutz.multipleProductResponseMeta
          pagination = meta ^?! Skroutz.metaPagination

      length items `shouldBe` 0

      pagination ^. Skroutz.paginationTotalResults `shouldBe` 0
      pagination ^. Skroutz.paginationTotalPages `shouldBe` 0
      pagination ^. Skroutz.paginationPage `shouldBe` 1
      pagination ^. Skroutz.paginationPer `shouldBe` 25
