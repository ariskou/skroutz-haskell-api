{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.ShopShipping
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability : non-portable
--
-- Provides the 'ShopShipping' type, the shipping methods supported by a
-- 'Web.Skroutz.Model.Base.Shop.Shop'.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.ShopShipping
where

import           Control.DeepSeq (NFData)
import           Data.Data       (Data, Typeable)
import           Data.Text       (Text)
import           GHC.Generics    (Generic)
import           Web.Skroutz.TH

data ShopShipping = ShopShipping {
    _shopShippingFree         :: Bool
  , _shopShippingFreeFrom     :: Maybe Int -- This could also be Double since it represents a price, but only integer examples have been seen until now.
  , _shopShippingFreeFromInfo :: Text
  , _shopShippingMinPrice     :: Text -- Returns double in quotes, e.g. "3.99"
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''ShopShipping "_shopShipping"
