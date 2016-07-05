{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.Base.ShopPaymentMethods
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'ShopPaymentMethods' type, the payment methods supported by a shop.
----------------------------------------------------------------------------
module Web.Skroutz.Types.Base.ShopPaymentMethods
where

import           Data.Text      (Text)
import           GHC.Generics   (Generic)
import           Web.Skroutz.TH

data ShopPaymentMethods = ShopPaymentMethods {
    _shopPaymentMethodsCreditCard   :: Bool
  , _shopPaymentMethodsPaypal       :: Bool
  , _shopPaymentMethodsBank         :: Bool
  , _shopPaymentMethodsSpotCash     :: Bool
  , _shopPaymentMethodsInstallments :: Text
  } deriving (Generic, Show)

makeLensesAndJSON ''ShopPaymentMethods "_shopPaymentMethods"
