{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ResultWrappers.Shop
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Shop' type, which is a merchant, not a physical store.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ResultWrappers.Shop
where

import           Control.DeepSeq                       (NFData)
import           Data.Data                             (Data, Typeable)
import           GHC.Generics                          (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Base.Shop
import           Web.Skroutz.Types.ResultWrappers.Meta

data SingleShopResponse = SingleShopResponse {
    _singleShopResponseShop :: Shop
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''SingleShopResponse "_singleShopResponse"

data MultipleShopResponse = MultipleShopResponse {
    _multipleShopResponseShops :: [Shop]
  , _multipleShopResponseMeta  :: Meta
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''MultipleShopResponse "_multipleShopResponse"
