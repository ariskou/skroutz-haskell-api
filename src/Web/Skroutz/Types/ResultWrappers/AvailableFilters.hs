{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ResultWrappers.AvailableFilters
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'AvailableFilters' type.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ResultWrappers.AvailableFilters
where

import           Control.DeepSeq (NFData)
import           Data.Data       (Data, Typeable)
import           Data.Map        (Map)
import           Data.Text       (Text)
import           GHC.Generics    (Generic)
import           Web.Skroutz.TH

data AvailableFilters = AvailableFilters {
    _availableFiltersFilters       :: Maybe (Map Text Int)
  , _availableFiltersManufacturers :: Maybe (Map Text Int)
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''AvailableFilters "_availableFilters"
