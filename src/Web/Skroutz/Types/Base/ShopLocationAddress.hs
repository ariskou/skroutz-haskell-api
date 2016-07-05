{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.Base.ShopLocationAddress
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'ShopLocationAddress' type, the structured address of a shop location.
----------------------------------------------------------------------------
module Web.Skroutz.Types.Base.ShopLocationAddress
where

import           Data.Text      (Text)
import           GHC.Generics   (Generic)
import           Web.Skroutz.TH

data ShopLocationAddress = ShopLocationAddress {
    _shopLocationAddressId           :: Maybe Int
  , _shopLocationAddressStreetNumber :: Maybe Text
  , _shopLocationAddressStreet       :: Maybe Text
  , _shopLocationAddressPostcode     :: Maybe Text
  , _shopLocationAddressCity         :: Maybe Text
  , _shopLocationAddressRegion       :: Maybe Text
  , _shopLocationAddressCountry      :: Maybe Text
  } deriving (Generic, Show)

makeLensesAndJSON ''ShopLocationAddress "_shopLocationAddress"
