{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ResultWrappers.StrongMatches
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'StrongMatches' type, used for strong match metadata in results.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ResultWrappers.StrongMatches
where

import           Control.DeepSeq                     (NFData)
import           Data.Data                           (Data, Typeable)
import           GHC.Generics                        (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Base.Category
import           Web.Skroutz.Types.Base.Manufacturer
import           Web.Skroutz.Types.Base.Shop
import           Web.Skroutz.Types.Base.Sku

data StrongMatches = StrongMatches {
    _strongMatchesCategory     :: Maybe Category
  , _strongMatchesManufacturer :: Maybe Manufacturer
  , _strongMatchesSku          :: Maybe Sku
  , _strongMatchesShop         :: Maybe Shop
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''StrongMatches "_strongMatches"
