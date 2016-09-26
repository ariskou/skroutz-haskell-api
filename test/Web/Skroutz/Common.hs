----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Common
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides common imports and functions needed int the HSpec tests.
----------------------------------------------------------------------------
module Web.Skroutz.Common
  (
    readJSON
  , mkUri
  , (^.)
  , (^?!)
  , ix
  , _JSON
  , Spec
  , SpecWith
  , Arg
  , Example
  , describe
  , hspec
  , it
  , shouldBe
  , shouldSatisfy
  )
where

import           Control.Lens         (ix, (^.), (^?!))
import           Data.Aeson.Lens      (_JSON)
import           Data.ByteString.Lazy (ByteString, readFile)
import           Data.Coerce          (coerce)
import           Data.Maybe           (fromJust)
import           Network.URI          (parseURI)
import           System.Directory     (getCurrentDirectory)
import           System.FilePath      ((</>))
import           Test.Hspec           (Spec, describe, hspec, it, shouldBe, shouldSatisfy, SpecWith, Arg, Example)
import qualified Web.Skroutz          as Skroutz

readJSON :: FilePath -> FilePath -> IO ByteString
readJSON category result = do
  dir <- getCurrentDirectory
  Data.ByteString.Lazy.readFile (dir </> "test" </> "fixtures" </> category </> (result ++ ".json"))

mkUri :: String -> Skroutz.URI
mkUri = coerce . fromJust . parseURI
