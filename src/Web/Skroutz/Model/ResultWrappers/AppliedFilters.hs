{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.ResultWrappers.AppliedFilters
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'AppliedFilters' type.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ResultWrappers.AppliedFilters
where

import           Control.DeepSeq (NFData)
import           Data.Data       (Data, Typeable)
import           GHC.Generics    (Generic)
import           Web.Skroutz.TH

data AppliedFilters = AppliedFilters {
    _appliedFiltersFilters       :: Maybe [Int]
  , _appliedFiltersManufacturers :: Maybe [Int]
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''AppliedFilters "_appliedFilters"
