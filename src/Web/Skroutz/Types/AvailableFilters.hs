{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.AvailableFilters
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'AvailableFilters' type.
----------------------------------------------------------------------------
module Web.Skroutz.Types.AvailableFilters
where

import           Data.Map       (Map)
import           Data.Text      (Text)
import           GHC.Generics   (Generic)
import           Web.Skroutz.TH

data AvailableFilters = AvailableFilters {
    _availableFiltersFilters       :: Maybe (Map Text Int)
  , _availableFiltersManufacturers :: Maybe (Map Text Int)
  } deriving (Generic, Show)

makeLensesAndJSON ''AvailableFilters "_availableFilters"
