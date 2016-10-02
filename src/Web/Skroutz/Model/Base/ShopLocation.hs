{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.ShopLocation
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability : non-portable
--
-- Provides the 'ShopLocation' type, the location of a specific physical shop store.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.ShopLocation
where

import           Control.DeepSeq                            (NFData)
import           Data.Data                                  (Data, Typeable)
import           Data.Text                                  (Text)
import           GHC.Generics                               (Generic)
import           Web.Skroutz.Model.Base.ShopLocationAddress
import           Web.Skroutz.Model.Base.ShopLocationFormat
import           Web.Skroutz.TH

data ShopLocation = ShopLocation {
    _shopLocationId          :: Int
  , _shopLocationHeadquarter :: Bool
  , _shopLocationPhones      :: [Text]
  , _shopLocationPickupPoint :: Bool
  , _shopLocationStore       :: Bool
  , _shopLocationFullAddress :: Text
  , _shopLocationFormat      :: ShopLocationFormat
  , _shopLocationLat         :: Text -- Returns double in quotes, e.g. "38.062297"
  , _shopLocationLng         :: Text -- Returns double in quotes, e.g. "23.75991"
  , _shopLocationInfo        :: Text
  , _shopLocationAddress     :: Maybe ShopLocationAddress
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''ShopLocation "_shopLocation"
