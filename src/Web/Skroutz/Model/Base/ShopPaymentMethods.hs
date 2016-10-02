{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.ShopPaymentMethods
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability : non-portable
--
-- Provides the 'ShopPaymentMethods' type, the payment methods supported by a shop.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.ShopPaymentMethods
where

import           Control.DeepSeq (NFData)
import           Data.Data       (Data, Typeable)
import           Data.Text       (Text)
import           GHC.Generics    (Generic)
import           Web.Skroutz.TH

data ShopPaymentMethods = ShopPaymentMethods {
    _shopPaymentMethodsCreditCard   :: Bool
  , _shopPaymentMethodsPaypal       :: Bool
  , _shopPaymentMethodsBank         :: Bool
  , _shopPaymentMethodsSpotCash     :: Bool
  , _shopPaymentMethodsInstallments :: Text
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''ShopPaymentMethods "_shopPaymentMethods"
