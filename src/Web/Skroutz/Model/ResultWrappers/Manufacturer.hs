{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.ResultWrappers.Manufacturer
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :  non-portable
--
-- Provides the 'SingleManufacturerResponse' and 'MultipleManufacturerResponse' types, to collect results of 'Manufacturer' type.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ResultWrappers.Manufacturer
where

import           Control.DeepSeq                       (NFData)
import           Data.Data                             (Data, Typeable)
import           GHC.Generics                          (Generic)
import           Web.Skroutz.Model.Base.Manufacturer
import           Web.Skroutz.Model.ResultWrappers.Meta
import           Web.Skroutz.TH

data SingleManufacturerResponse = SingleManufacturerResponse {
    _singleManufacturerResponseManufacturer :: Manufacturer
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''SingleManufacturerResponse "_singleManufacturerResponse"

data MultipleManufacturerResponse = MultipleManufacturerResponse {
    _multipleManufacturerResponseManufacturers :: [Manufacturer]
  , _multipleManufacturerResponseMeta          :: Meta
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''MultipleManufacturerResponse "_multipleManufacturerResponse"
