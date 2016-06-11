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

readJSON :: FilePath -> FilePath -> IO BS.ByteString
readJSON category result = do
  dir <- getCurrentDirectory
  BS.readFile (dir </> "test" </> "fixtures" </> category </> (result ++ ".json"))

main :: IO ()
main = hspec $ do
  describe "Skroutz" $ do
    describe "JSON Parsing" $ do
      it "parses a single Category" $ do
        resp <- readJSON "category" "successful_one_response_body.json.formatted"
        print resp
      it "parses a list of Categories" $ do
        resp <- readJSON "category" "successful_all_response_body.json.formatted"
        print resp
