{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DeriveDataTypeable    #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.ResultWrappers.OrderBy
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability : non-portable
--
-- Provides the 'OrderBy' type, a type representing the possible types of ordering in searches.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ResultWrappers.OrderBy
where

import           Control.DeepSeq (NFData)
import           Data.Data       (Data, Typeable)
import           GHC.Generics    (Generic)
import           Web.Skroutz.TH

data OrderBy = OrderByPopularity | OrderByPrice | OrderByPricevat | OrderByRating | OrderByName
  deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSONSumType ''OrderBy "" "OrderBy"
