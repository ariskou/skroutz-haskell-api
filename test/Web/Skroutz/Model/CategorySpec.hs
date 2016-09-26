{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE ExplicitForAll #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE PartialTypeSignatures #-}

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
import qualified Data.Aeson as Aeson
import Data.Either (isRight)
import Data.Proxy (Proxy (..))

main :: IO ()
main = hspec spec

genericSpec :: forall a . (Show a, Aeson.FromJSON a) => Proxy a -> String -> FilePath -> FilePath -> SpecWith ()
genericSpec _ description fixtureDir fixtureFilename =
  it description $ do
    resp <- readJSON fixtureDir fixtureFilename
    (Aeson.eitherDecode resp :: Either String a) `shouldSatisfy` isRight

spec :: Spec
spec =
  describe "JSON Parsing" $ do
    genericSpec (Proxy :: Proxy Skroutz.SingleCategoryResponse) "parses a single Category" "category" "successful_one_response_body.json.formatted"

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

      -- item0 ^. Skroutz.categoryId `shouldBe` 1
      -- item0 ^. Skroutz.categoryName `shouldBe` "Σταθερή Τηλεφωνία"
      -- item0 ^. Skroutz.categoryChildrenCount `shouldBe` 5
      -- item0 ^. Skroutz.categoryImageUrl `shouldBe` mkUri "http://c.scdn.gr/ds/categories/1/20150508125916_c7ffab14.jpg"
      -- item0 ^. Skroutz.categoryParentId `shouldBe` 2
      -- item0 ^. Skroutz.categoryFashion `shouldBe` False
      -- item0 ^. Skroutz.categoryLayoutMode `shouldBe` "list"
      -- item0 ^. Skroutz.categoryWebUri `shouldBe` mkUri "http://skroutz.gr/c/1/statherh-tilefwnia.html"
      -- item0 ^. Skroutz.categoryCode `shouldBe` "statherh-tilefwnia"
      -- item0 ^. Skroutz.categoryPath `shouldBe` "76,1269,2,1"
      -- item0 ^. Skroutz.categoryShowSpecifications `shouldBe` False
      -- item0 ^. Skroutz.categoryManufacturerTitle `shouldBe` "Κατασκευαστές"
