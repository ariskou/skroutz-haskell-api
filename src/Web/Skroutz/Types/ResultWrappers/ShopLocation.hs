{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ResultWrappers.ShopLocation
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'ShopLocation' type, the location of a specific physical shop store.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ResultWrappers.ShopLocation
where

import           GHC.Generics                          (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Base.ShopLocation
import           Web.Skroutz.Types.ResultWrappers.Meta

data SingleShopLocationResponse = SingleShopLocationResponse {
    _singleShopLocationResponseLocation :: ShopLocation
  } deriving (Generic, Show)

makeLensesAndJSON ''SingleShopLocationResponse "_singleShopLocationResponse"

data MultipleShopLocationResponse = MultipleShopLocationResponse {
    _multipleShopLocationResponseLocations :: [ShopLocation]
  , _multipleShopLocationResponseMeta      :: Meta
  } deriving (Generic, Show)

makeLensesAndJSON ''MultipleShopLocationResponse "_multipleShopLocationResponse"
