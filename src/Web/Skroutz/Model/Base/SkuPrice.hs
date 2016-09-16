{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.SkuPrice
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'SkuPrice' type, the price of an 'SKU'.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.SkuPrice
where

import           Control.DeepSeq (NFData)
import           Data.Data       (Data, Typeable)
import           Data.Text       (Text)
import           GHC.Generics    (Generic)
import           Web.Skroutz.TH

data SkuPrice = SkuPrice {
    _skuPriceDate     :: Text
  , _skuPricePrice    :: Double
  , _skuPriceShopName :: Maybe Text
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''SkuPrice "_skuPrice"
