{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.ShopLocationAddress
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability : non-portable
--
-- Provides the 'ShopLocationAddress' type, the structured address of a
-- 'Web.Skroutz.Model.Base.ShopLocation.ShopLocation'.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.ShopLocationAddress
where

import           Control.DeepSeq (NFData)
import           Data.Data       (Data, Typeable)
import           Data.Text       (Text)
import           GHC.Generics    (Generic)
import           Web.Skroutz.TH

data ShopLocationAddress = ShopLocationAddress {
    _shopLocationAddressId           :: Maybe Int
  , _shopLocationAddressStreetNumber :: Maybe Text
  , _shopLocationAddressStreet       :: Maybe Text
  , _shopLocationAddressPostcode     :: Maybe Text
  , _shopLocationAddressCity         :: Maybe Text
  , _shopLocationAddressRegion       :: Maybe Text
  , _shopLocationAddressCountry      :: Maybe Text
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''ShopLocationAddress "_shopLocationAddress"
