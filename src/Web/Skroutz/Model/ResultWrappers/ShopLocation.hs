{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.ResultWrappers.ShopLocation
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'ShopLocation' type, the location of a specific physical shop store.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ResultWrappers.ShopLocation
where

import           Control.DeepSeq                       (NFData)
import           Data.Data                             (Data, Typeable)
import           GHC.Generics                          (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Model.Base.ShopLocation
import           Web.Skroutz.Model.ResultWrappers.Meta

data SingleShopLocationResponse = SingleShopLocationResponse {
    _singleShopLocationResponseLocation :: ShopLocation
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''SingleShopLocationResponse "_singleShopLocationResponse"

data MultipleShopLocationResponse = MultipleShopLocationResponse {
    _multipleShopLocationResponseLocations :: [ShopLocation]
  , _multipleShopLocationResponseMeta      :: Meta
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''MultipleShopLocationResponse "_multipleShopLocationResponse"
