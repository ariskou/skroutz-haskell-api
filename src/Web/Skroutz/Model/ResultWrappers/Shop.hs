{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.ResultWrappers.Shop
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability : non-portable
--
-- Provides the 'Shop' type, which is a merchant, not a physical store.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ResultWrappers.Shop
where

import           Control.DeepSeq                       (NFData)
import           Data.Data                             (Data, Typeable)
import           GHC.Generics                          (Generic)
import           Web.Skroutz.Model.Base.Shop
import           Web.Skroutz.Model.ResultWrappers.Meta
import           Web.Skroutz.TH

data SingleShopResponse = SingleShopResponse {
    _singleShopResponseShop :: Shop
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''SingleShopResponse "_singleShopResponse"

data MultipleShopResponse = MultipleShopResponse {
    _multipleShopResponseShops :: [Shop]
  , _multipleShopResponseMeta  :: Meta
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''MultipleShopResponse "_multipleShopResponse"
