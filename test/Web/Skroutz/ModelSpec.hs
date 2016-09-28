{-# LANGUAGE ExplicitForAll        #-}
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

import qualified Data.Aeson             as Aeson
import           Data.ByteString.Lazy   (ByteString, readFile)
import           Data.Either            (isRight)
import           Data.HList             (ApplyAB, applyAB, hMapM_)
import           Data.Proxy             (Proxy (..))
import           System.Directory       (getCurrentDirectory)
import           System.FilePath        ((</>))
import           Test.Hspec             (Spec, SpecWith, describe, hspec, it, shouldSatisfy)
import qualified Web.Skroutz            as Skroutz
import           Web.Skroutz.ApiEntries (apiEntries)

readJSON :: FilePath -> FilePath -> IO ByteString
readJSON fixtureDir fixtureName = do
  dir <- getCurrentDirectory
  Data.ByteString.Lazy.readFile (dir </> "test" </> "fixtures" </> fixtureDir </> (fixtureName ++ ".json"))

tokenSpec :: SpecWith ()
tokenSpec =
  it "parses a single Token" $ do
    resp <- readJSON "get_application_token" "successful_response_body.json.formatted"
    (Aeson.eitherDecode resp :: Either String Skroutz.Token) `shouldSatisfy` isRight

generatedFixtureSpec :: forall a . (Show a, Aeson.FromJSON a) => Proxy a -> String -> FilePath -> SpecWith ()
generatedFixtureSpec _ description fixtureFilename =
  it description $ do
    resp <- readJSON "generated" fixtureFilename
    (Aeson.eitherDecode resp :: Either String a) `shouldSatisfy` isRight

data HTestFixtureT = HTestFixtureT

instance (from ~ (String, String, _a, Proxy b), to ~ SpecWith (), Show b, Aeson.FromJSON b) => ApplyAB HTestFixtureT from to where
  applyAB HTestFixtureT (fixtureName, _, _, proxy) = generatedFixtureSpec proxy fixtureName fixtureName

spec :: Spec
spec = do
  describe "JSON Parsing of fake data" tokenSpec
  describe "JSON Parsing of real data" $ hMapM_ HTestFixtureT apiEntries

main :: IO ()
main = hspec spec
