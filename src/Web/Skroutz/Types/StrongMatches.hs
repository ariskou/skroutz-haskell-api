{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.StrongMatches
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'StrongMatches' type, used for strong match metadata in results.
----------------------------------------------------------------------------
module Web.Skroutz.Types.StrongMatches
where

import           GHC.Generics                   (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Category
import           Web.Skroutz.Types.Manufacturer
import           Web.Skroutz.Types.Shop
import           Web.Skroutz.Types.Sku

data StrongMatches = StrongMatches {
    _strongMatchesCategory     :: Maybe Category
  , _strongMatchesManufacturer :: Maybe Manufacturer
  , _strongMatchesSku          :: Maybe Sku
  , _strongMatchesShop         :: Maybe Shop
  } deriving (Generic, Show)

makeLensesAndJSON ''StrongMatches "_strongMatches"
