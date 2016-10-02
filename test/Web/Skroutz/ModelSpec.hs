{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE GADTs                 #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE UndecidableInstances  #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.ModelSpec
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability : non-portable
--
-- Provides the Hspec tests for the types in 'Web.Skroutz.Model'.
----------------------------------------------------------------------------
module Web.Skroutz.ModelSpec
(
    main
  , spec
)
where

import qualified Data.Aeson                     as Aeson
import           Data.ByteString.Lazy           (ByteString, readFile)
import           Data.Either                    (isRight)
import           Data.Foldable                  (traverse_)
import           System.FilePath                ((</>))
import           Test.Hspec                     (Spec, SpecWith, describe, hspec, it, shouldSatisfy)
import qualified Web.Skroutz                    as Skroutz
import           Web.Skroutz.ApiEntries         (ApiEntry, apiEntries)
import           Web.Skroutz.TestingEnvironment (getFixtureDir)

readJSON :: FilePath -> FilePath -> IO ByteString
readJSON fixtureCategory fixtureName = do
  baseFixtureDir <- getFixtureDir
  Data.ByteString.Lazy.readFile (baseFixtureDir </> fixtureCategory </> (fixtureName ++ ".json"))

tokenSpec :: SpecWith ()
tokenSpec =
  it "parses a single Token" $ do
    resp <- readJSON "get_application_token" "successful_response_body.json.formatted"
    (Aeson.eitherDecode resp :: Either String Skroutz.Token) `shouldSatisfy` isRight

generatedFixtureSpec :: ApiEntry -> SpecWith ()
generatedFixtureSpec (description, _, _, checkDecoder)  =
  it description $ do
    resp <- readJSON "generated" description
    checkDecoder resp `shouldSatisfy` isRight

spec :: Spec
spec = do
  describe "Loading and parsing stored copies of previously retrieved (via the API) JSON data, slightly falsified for security purposes" tokenSpec
  describe "Loading and parsing stored copies of real, previously retrieved (via the API) JSON data" $ traverse_ generatedFixtureSpec apiEntries

main :: IO ()
main = hspec spec
