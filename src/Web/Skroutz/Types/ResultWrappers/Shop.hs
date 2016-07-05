{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
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

import           GHC.Generics                          (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Base.Shop
import           Web.Skroutz.Types.ResultWrappers.Meta

data SingleShopResponse = SingleShopResponse {
    _singleShopResponseShop :: Shop
  } deriving (Generic, Show)

makeLensesAndJSON ''SingleShopResponse "_singleShopResponse"

data MultipleShopResponse = MultipleShopResponse {
    _multipleShopResponseShops :: [Shop]
  , _multipleShopResponseMeta  :: Meta
  } deriving (Generic, Show)

makeLensesAndJSON ''MultipleShopResponse "_multipleShopResponse"
