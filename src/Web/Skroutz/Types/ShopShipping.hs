{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ShopShipping
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'ShopShipping' type, the shipping methods supported by a shop.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ShopShipping
where

import           Data.Text      (Text)
import           GHC.Generics   (Generic)
import           Web.Skroutz.TH

data ShopShipping = ShopShipping {
    _shopShippingFree         :: Bool
  , _shopShippingFreeFrom     :: Int
  , _shopShippingFreeFromInfo :: Text
  , _shopShippingMinPrice     :: Text
  } deriving (Generic, Show)

makeLensesAndJSON ''ShopShipping "_shopShipping"
