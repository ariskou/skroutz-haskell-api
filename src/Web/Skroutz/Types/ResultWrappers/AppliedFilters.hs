{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ResultWrappers.AppliedFilters
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'AppliedFilters' type.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ResultWrappers.AppliedFilters
where

import           GHC.Generics   (Generic)
import           Web.Skroutz.TH

data AppliedFilters = AppliedFilters {
    _appliedFiltersFilters       :: Maybe [Int]
  , _appliedFiltersManufacturers :: Maybe [Int]
  } deriving (Generic, Show)

makeLensesAndJSON ''AppliedFilters "_appliedFilters"
