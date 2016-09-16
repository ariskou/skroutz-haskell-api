{-# LANGUAGE OverloadedStrings #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.ManufacturerSpec
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Hspec tests for the 'Manufacturer' type.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ManufacturerSpec
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
    it "parses a single Manufacturer" $ do
      resp <- readJSON "manufacturer" "successful_one_response_body.json.formatted"
      let item = resp ^?! (_JSON . Skroutz.singleManufacturerResponseManufacturer) :: Skroutz.Manufacturer
      item ^. Skroutz.manufacturerId `shouldBe` 12907
      item ^. Skroutz.manufacturerName `shouldBe` "Rapala"
      item ^. Skroutz.manufacturerImageUrl `shouldBe` Nothing


    it "parses a list of Manufacturers" $ do
      resp <- readJSON "manufacturer" "successful_all_response_body.json.formatted"
      let itemsMultiple = resp ^?! _JSON :: Skroutz.MultipleManufacturerResponse
          items = itemsMultiple ^?! Skroutz.multipleManufacturerResponseManufacturers
          meta = itemsMultiple ^?! Skroutz.multipleManufacturerResponseMeta
          pagination = meta ^?! Skroutz.metaPagination
          item0 = items ^?! ix 0

      length items `shouldBe` 25

      pagination ^. Skroutz.paginationTotalResults `shouldBe` 25827
      pagination ^. Skroutz.paginationTotalPages `shouldBe` 1034
      pagination ^. Skroutz.paginationPage `shouldBe` 1
      pagination ^. Skroutz.paginationPer `shouldBe` 25

      item0 ^. Skroutz.manufacturerId `shouldBe` 1
      item0 ^. Skroutz.manufacturerName `shouldBe` "EA - Electronic Arts"
      item0 ^. Skroutz.manufacturerImageUrl `shouldBe` (Just $ mkUri "http://c.scdn.gr/ds/manufacturers/1/e2e019eea82bfe6b82b47ab77f6b4497.png")
