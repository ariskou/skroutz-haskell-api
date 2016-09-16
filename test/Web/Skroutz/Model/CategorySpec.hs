{-# LANGUAGE OverloadedStrings #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.CategorySpec
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Hspec tests for the 'Category' type.
----------------------------------------------------------------------------
module Web.Skroutz.Model.CategorySpec
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
    it "parses a single Category" $ do
      resp <- readJSON "category" "successful_one_response_body.json.formatted"
      let item = resp ^?! (_JSON . Skroutz.singleCategoryResponseCategory) :: Skroutz.Category
      item ^. Skroutz.categoryId `shouldBe` 1442
      item ^. Skroutz.categoryName `shouldBe` "Ξαπλώστρες Κήπου & Βεράντας"
      item ^. Skroutz.categoryChildrenCount `shouldBe` 0
      item ^. Skroutz.categoryImageUrl `shouldBe` mkUri "http://a.scdn.gr/ds/categories/1442/1442.jpg"
      item ^. Skroutz.categoryParentId `shouldBe` 1434
      item ^. Skroutz.categoryFashion `shouldBe` False
      item ^. Skroutz.categoryLayoutMode `shouldBe` "tiles"
      item ^. Skroutz.categoryWebUri `shouldBe` mkUri "http://skroutz.gr/c/1442/xaplostres-kipou-verantas.html"
      item ^. Skroutz.categoryCode `shouldBe` "xaplostres-kipou-verantas"
      item ^. Skroutz.categoryPath `shouldBe` "76,11,1052,1434,1442"
      item ^. Skroutz.categoryShowSpecifications `shouldBe` False
      item ^. Skroutz.categoryManufacturerTitle `shouldBe` "Κατασκευαστές"


    it "parses a list of Categories" $ do
      resp <- readJSON "category" "successful_all_response_body.json.formatted"
      let itemsMultiple = resp ^?! _JSON :: Skroutz.MultipleCategoryResponse
          items = itemsMultiple ^?! Skroutz.multipleCategoryResponseCategories
          meta = itemsMultiple ^?! Skroutz.multipleCategoryResponseMeta
          pagination = meta ^?! Skroutz.metaPagination
          item0 = items ^?! ix 0

      length items `shouldBe` 25

      pagination ^. Skroutz.paginationTotalResults `shouldBe` 2303
      pagination ^. Skroutz.paginationTotalPages `shouldBe` 93
      pagination ^. Skroutz.paginationPage `shouldBe` 1
      pagination ^. Skroutz.paginationPer `shouldBe` 25

      item0 ^. Skroutz.categoryId `shouldBe` 1
      item0 ^. Skroutz.categoryName `shouldBe` "Σταθερή Τηλεφωνία"
      item0 ^. Skroutz.categoryChildrenCount `shouldBe` 5
      item0 ^. Skroutz.categoryImageUrl `shouldBe` mkUri "http://c.scdn.gr/ds/categories/1/20150508125916_c7ffab14.jpg"
      item0 ^. Skroutz.categoryParentId `shouldBe` 2
      item0 ^. Skroutz.categoryFashion `shouldBe` False
      item0 ^. Skroutz.categoryLayoutMode `shouldBe` "list"
      item0 ^. Skroutz.categoryWebUri `shouldBe` mkUri "http://skroutz.gr/c/1/statherh-tilefwnia.html"
      item0 ^. Skroutz.categoryCode `shouldBe` "statherh-tilefwnia"
      item0 ^. Skroutz.categoryPath `shouldBe` "76,1269,2,1"
      item0 ^. Skroutz.categoryShowSpecifications `shouldBe` False
      item0 ^. Skroutz.categoryManufacturerTitle `shouldBe` "Κατασκευαστές"
