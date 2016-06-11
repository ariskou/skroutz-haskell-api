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

import qualified Web.Skroutz              as Skroutz
import qualified Data.ByteString          as BS
import           Test.Hspec
import           System.FilePath          ((</>))
import           System.Directory         (getCurrentDirectory)
import           Control.Lens
import           Data.Aeson.Lens          (key, nth, _JSON)
import qualified Data.Text
import qualified Data.Text.Encoding

default (Data.Text.Text)

readJSON :: FilePath -> FilePath -> IO Data.Text.Text
readJSON category result = do
  dir <- getCurrentDirectory
  Data.Text.Encoding.decodeUtf8 <$> BS.readFile (dir </> "test" </> "fixtures" </> category </> (result ++ ".json"))

main :: IO ()
main = hspec $ do
  describe "Skroutz" $ do
    describe "JSON Parsing" $ do
      it "parses a single Category" $ do
        resp <- readJSON "category" "successful_one_response_body.json.formatted"
        let item = resp ^?! (key "category" . _JSON) :: Skroutz.Category
        (item ^. Skroutz.identifier) `shouldBe` 1442
        (item ^. Skroutz.name) `shouldBe` "Ξαπλώστρες Κήπου & Βεράντας"
        (item ^. Skroutz.childrenCount) `shouldBe` 0
        (item ^. Skroutz.imageUrl) `shouldBe` "http://a.scdn.gr/ds/categories/1442/1442.jpg"
        (item ^. Skroutz.parentId) `shouldBe` 1434
        (item ^. Skroutz.fashion) `shouldBe` False
        (item ^. Skroutz.layoutMode) `shouldBe` "tiles"
        (item ^. Skroutz.webUri) `shouldBe` "http://skroutz.gr/c/1442/xaplostres-kipou-verantas.html"
        (item ^. Skroutz.code) `shouldBe` "xaplostres-kipou-verantas"
        (item ^. Skroutz.path) `shouldBe` "76,11,1052,1434,1442"
        (item ^. Skroutz.showSpecifications) `shouldBe` False
        (item ^. Skroutz.manufacturerTitle) `shouldBe` "Κατασκευαστές"


      it "parses a list of Categories" $ do
        resp <- readJSON "category" "successful_all_response_body.json.formatted"
        let item = resp ^?! (key "categories" . nth 0 . _JSON) :: Skroutz.Category
        (item ^. Skroutz.identifier) `shouldBe` 1
        (item ^. Skroutz.name) `shouldBe` "Σταθερή Τηλεφωνία"
        (item ^. Skroutz.childrenCount) `shouldBe` 5
        (item ^. Skroutz.imageUrl) `shouldBe` "http://c.scdn.gr/ds/categories/1/20150508125916_c7ffab14.jpg"
        (item ^. Skroutz.parentId) `shouldBe` 2
        (item ^. Skroutz.fashion) `shouldBe` False
        (item ^. Skroutz.layoutMode) `shouldBe` "list"
        (item ^. Skroutz.webUri) `shouldBe` "http://skroutz.gr/c/1/statherh-tilefwnia.html"
        (item ^. Skroutz.code) `shouldBe` "statherh-tilefwnia"
        (item ^. Skroutz.path) `shouldBe` "76,1269,2,1"
        (item ^. Skroutz.showSpecifications) `shouldBe` False
        (item ^. Skroutz.manufacturerTitle) `shouldBe` "Κατασκευαστές"
