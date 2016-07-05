{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.Base.ShopLocation
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'ShopLocation' type, the location of a specific physical shop store.
----------------------------------------------------------------------------
module Web.Skroutz.Types.Base.ShopLocation
where

import           Data.Text                                  (Text)
import           GHC.Generics                               (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Base.ShopLocationAddress

data ShopLocation = ShopLocation {
    _shopLocationId          :: Int
  , _shopLocationHeadquarter :: Bool
  , _shopLocationPhones      :: [Text]
  , _shopLocationPickupPoint :: Bool
  , _shopLocationStore       :: Bool
  , _shopLocationFullAddress :: Text
  , _shopLocationFormat      :: Text
  , _shopLocationLat         :: Text
  , _shopLocationLng         :: Text
  , _shopLocationInfo        :: Text
  , _shopLocationAddress     :: Maybe ShopLocationAddress
  } deriving (Generic, Show)

makeLensesAndJSON ''ShopLocation "_shopLocation"
