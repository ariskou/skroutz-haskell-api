{-# LANGUAGE OverloadedStrings #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Main
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Hspec tests
----------------------------------------------------------------------------
module Main
where

import           Control.Lens       ((^.), (^?!))
import           Data.Aeson.Lens    (key, nth, _JSON)
import           Data.ByteString    (readFile)
import           Data.Coerce        (coerce)
import           Data.Maybe         (fromJust)
import qualified Data.Text
import           Data.Text.Encoding (decodeUtf8)
import           Network.URI        (parseURI)
import           System.Directory   (getCurrentDirectory)
import           System.FilePath    ((</>))
import           Test.Hspec         (describe, hspec, it, shouldBe)
import qualified Web.Skroutz        as Skroutz

readJSON :: FilePath -> FilePath -> IO Data.Text.Text
readJSON category result = do
  dir <- getCurrentDirectory
  Data.Text.Encoding.decodeUtf8 <$> Data.ByteString.readFile (dir </> "test" </> "fixtures" </> category </> (result ++ ".json"))

mkUri :: String -> Skroutz.URI
mkUri = coerce . fromJust . parseURI

main :: IO ()
main = hspec $
  describe "Skroutz" $
    describe "JSON Parsing" $ do
      it "parses a single Category" $ do
        resp <- readJSON "category" "successful_one_response_body.json.formatted"
        let item = resp ^?! (key "category" . _JSON) :: Skroutz.Category
        (item ^. Skroutz.categoryId) `shouldBe` 1442
        (item ^. Skroutz.categoryName) `shouldBe` "Ξαπλώστρες Κήπου & Βεράντας"
        (item ^. Skroutz.categoryChildrenCount) `shouldBe` 0
        (item ^. Skroutz.categoryImageUrl) `shouldBe` mkUri "http://a.scdn.gr/ds/categories/1442/1442.jpg"
        (item ^. Skroutz.categoryParentId) `shouldBe` 1434
        (item ^. Skroutz.categoryFashion) `shouldBe` False
        (item ^. Skroutz.categoryLayoutMode) `shouldBe` "tiles"
        (item ^. Skroutz.categoryWebUri) `shouldBe` mkUri "http://skroutz.gr/c/1442/xaplostres-kipou-verantas.html"
        (item ^. Skroutz.categoryCode) `shouldBe` "xaplostres-kipou-verantas"
        (item ^. Skroutz.categoryPath) `shouldBe` "76,11,1052,1434,1442"
        (item ^. Skroutz.categoryShowSpecifications) `shouldBe` False
        (item ^. Skroutz.categoryManufacturerTitle) `shouldBe` "Κατασκευαστές"

      it "parses a list of Categories" $ do
        resp <- readJSON "category" "successful_all_response_body.json.formatted"
        let item = resp ^?! (key "categories" . nth 0 . _JSON) :: Skroutz.Category
        (item ^. Skroutz.categoryId) `shouldBe` 1
        (item ^. Skroutz.categoryName) `shouldBe` "Σταθερή Τηλεφωνία"
        (item ^. Skroutz.categoryChildrenCount) `shouldBe` 5
        (item ^. Skroutz.categoryImageUrl) `shouldBe` mkUri "http://c.scdn.gr/ds/categories/1/20150508125916_c7ffab14.jpg"
        (item ^. Skroutz.categoryParentId) `shouldBe` 2
        (item ^. Skroutz.categoryFashion) `shouldBe` False
        (item ^. Skroutz.categoryLayoutMode) `shouldBe` "list"
        (item ^. Skroutz.categoryWebUri) `shouldBe` mkUri "http://skroutz.gr/c/1/statherh-tilefwnia.html"
        (item ^. Skroutz.categoryCode) `shouldBe` "statherh-tilefwnia"
        (item ^. Skroutz.categoryPath) `shouldBe` "76,1269,2,1"
        (item ^. Skroutz.categoryShowSpecifications) `shouldBe` False
        (item ^. Skroutz.categoryManufacturerTitle) `shouldBe` "Κατασκευαστές"

      it "parses a single Manufacturer" $ do
        resp <- readJSON "manufacturer" "successful_one_response_body.json.formatted"
        let item = resp ^?! (key "manufacturer" . _JSON) :: Skroutz.Manufacturer
        (item ^. Skroutz.manufacturerId) `shouldBe` 12907
        (item ^. Skroutz.manufacturerName) `shouldBe` "Rapala"
        (item ^. Skroutz.manufacturerImageUrl) `shouldBe` Nothing
