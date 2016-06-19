{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ShopLocationAddress
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'ShopLocationAddress' type, the structured address of a shop location.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ShopLocationAddress
where

import           Data.Text
import           GHC.Generics   (Generic)
import           Web.Skroutz.TH

data ShopLocationAddress = ShopLocationAddress {
    _shopLocationAddressId           :: Int
  , _shopLocationAddressStreetNumber :: Text
  , _shopLocationAddressStreet       :: Text
  , _shopLocationAddressPostcode     :: Text
  , _shopLocationAddressCity         :: Text
  , _shopLocationAddressRegion       :: Text
  , _shopLocationAddressCountry      :: Text
  } deriving (Generic, Show)

makeLensesAndJSON ''ShopLocationAddress "_shopLocationAddress"
