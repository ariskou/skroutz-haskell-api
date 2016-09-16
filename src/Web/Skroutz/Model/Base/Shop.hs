{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.Base.Shop
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Shop' type, which is a merchant, not a physical store.
----------------------------------------------------------------------------
module Web.Skroutz.Types.Base.Shop
where

import           Control.DeepSeq                           (NFData)
import           Data.Data                                 (Data, Typeable)
import           Data.Text                                 (Text)
import           GHC.Generics                              (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Base.ShopPaymentMethods
import           Web.Skroutz.Types.Base.ShopShipping
import           Web.Skroutz.Types.Base.URI

data Shop = Shop {
    _shopId                 :: Int
  , _shopName               :: Text
  , _shopLink               :: URI
  , _shopPhone              :: Text
  , _shopImageUrl           :: URI
  , _shopThumbshotUrl       :: URI
  , _shopReviewsCount       :: Int
  , _shopLatestReviewsCount :: Int
  , _shopReviewScore        :: Double
  , _shopPaymentMethods     :: ShopPaymentMethods
  , _shopShipping           :: ShopShipping
  , _shopWebUri             :: URI
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''Shop "_shop"
