{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.Shop
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Shop' type, which is a merchant, not a physical store.
----------------------------------------------------------------------------
module Web.Skroutz.Types.Shop
where

import           Data.Text
import           GHC.Generics                         (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Meta
import           Web.Skroutz.Types.ShopPaymentMethods
import           Web.Skroutz.Types.ShopShipping
import           Web.Skroutz.Types.URI

data Shop = Shop {
    _shopId                 :: Int
  , _shopName               :: Text
  , _shopLink               :: URI
  , _shopPhone              :: Text
  , _shopImageUrl           :: URI
  , _shopThumbshotUrl       :: URI
  , _shopReviewsCount       :: Int
  , _shopLatestReviewsCount :: Int
  , _shopPaymentMethods     :: ShopPaymentMethods
  , _shopShipping           :: ShopShipping
  , _shopWebUri             :: URI
  } deriving (Generic, Show)

makeLensesAndJSON ''Shop "_shop"

data SingleShopResponse = SingleShopResponse {
    _singleShopResponseShop :: Shop
  } deriving (Generic, Show)

makeLensesAndJSON ''SingleShopResponse "_singleShopResponse"

data MultipleShopResponse = MultipleShopResponse {
    _multipleShopResponseShops :: [Shop]
  , _multipleShopResponseMeta  :: Meta
  } deriving (Generic, Show)

makeLensesAndJSON ''MultipleShopResponse "_multipleShopResponse"
