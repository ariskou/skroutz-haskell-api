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
    genericSpec (Proxy :: Proxy Skroutz.MultipleCategoryResponse) "parses a list of Categories" "category" "successful_all_response_body.json.formatted"

main :: IO ()
main = hspec spec
