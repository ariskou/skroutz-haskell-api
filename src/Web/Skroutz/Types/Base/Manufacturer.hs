{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.Base.Manufacturer
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Manufacturer' type.
----------------------------------------------------------------------------
module Web.Skroutz.Types.Base.Manufacturer
where

import           Data.Text              (Text)
import           GHC.Generics           (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Base.Meta
import           Web.Skroutz.Types.Base.URI

data Manufacturer = Manufacturer {
    _manufacturerId       :: Int
  , _manufacturerName     :: Text
  , _manufacturerImageUrl :: Maybe URI
  } deriving (Generic, Show)

makeLensesAndJSON ''Manufacturer "_manufacturer"

data SingleManufacturerResponse = SingleManufacturerResponse {
    _singleManufacturerResponseManufacturer :: Manufacturer
  } deriving (Generic, Show)

makeLensesAndJSON ''SingleManufacturerResponse "_singleManufacturerResponse"

data MultipleManufacturerResponse = MultipleManufacturerResponse {
    _multipleManufacturerResponseManufacturers :: [Manufacturer]
  , _multipleManufacturerResponseMeta          :: Meta
  } deriving (Generic, Show)

makeLensesAndJSON ''MultipleManufacturerResponse "_multipleManufacturerResponse"
