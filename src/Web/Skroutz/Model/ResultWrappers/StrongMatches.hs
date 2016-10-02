{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.ResultWrappers.StrongMatches
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :  non-portable
--
-- Provides the 'StrongMatches' type, used for strong match metadata in results.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ResultWrappers.StrongMatches
where

import           Control.DeepSeq                     (NFData)
import           Data.Data                           (Data, Typeable)
import           GHC.Generics                        (Generic)
import           Web.Skroutz.Model.Base.Category
import           Web.Skroutz.Model.Base.Manufacturer
import           Web.Skroutz.Model.Base.Shop
import           Web.Skroutz.Model.Base.Sku
import           Web.Skroutz.TH

data StrongMatches = StrongMatches {
    _strongMatchesCategory     :: Maybe Category
  , _strongMatchesManufacturer :: Maybe Manufacturer
  , _strongMatchesSku          :: Maybe Sku
  , _strongMatchesShop         :: Maybe Shop
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''StrongMatches "_strongMatches"
