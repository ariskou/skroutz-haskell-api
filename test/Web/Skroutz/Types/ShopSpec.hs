{-# LANGUAGE OverloadedStrings #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ShopSpec
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Hspec tests for the 'Shop' type.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ShopSpec
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
    it "parses a single Shop" $ do
      resp <- readJSON "shop" "successful_one_response_body.json.formatted"
      let item = resp ^?! (_JSON . Skroutz.singleShopResponseShop) :: Skroutz.Shop
      item ^. Skroutz.shopId `shouldBe` 452
      item ^. Skroutz.shopName `shouldBe` "Kotsovolos"
      item ^. Skroutz.shopLink `shouldBe` mkUri "http://www.kotsovolos.gr"
      item ^. Skroutz.shopPhone `shouldBe` "2102899999"
      item ^. Skroutz.shopImageUrl `shouldBe` mkUri "http://c.scdn.gr/ds/shops/logos/452/mid_d5867ac8-867b-4395-99bc-db04e459fe4d.jpg"
      item ^. Skroutz.shopThumbshotUrl `shouldBe` mkUri "http://d.scdn.gr/ds/shops/screenshots/452/20150731105054_75756119.png"
      item ^. Skroutz.shopReviewsCount `shouldBe` 388
      item ^. Skroutz.shopLatestReviewsCount `shouldBe` 99
      item ^. Skroutz.shopReviewScore `shouldBe` 3.01
      -- item ^. Skroutz.shopPaymentMethods `shouldBe`
      -- item ^. Skroutz.shopShipping `shouldBe`
      -- item ^. Skroutz.shopWebUri `shouldBe`


    it "parses an empty list of Shops" $ do
      resp <- readJSON "shop" "no_results_response_body.json.formatted"
      let itemsMultiple = resp ^?! _JSON :: Skroutz.MultipleShopResponse
          items = itemsMultiple ^?! Skroutz.multipleShopResponseShops
          meta = itemsMultiple ^?! Skroutz.multipleShopResponseMeta
          pagination = meta ^?! Skroutz.metaPagination

      length items `shouldBe` 0

      pagination ^. Skroutz.paginationTotalResults `shouldBe` 0
      pagination ^. Skroutz.paginationTotalPages `shouldBe` 0
      pagination ^. Skroutz.paginationPage `shouldBe` 1
      pagination ^. Skroutz.paginationPer `shouldBe` 25
