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
-- Portability :  non-portable
--
-- Provides the 'SkuPrice' type, the price of an 'Web.Skroutz.Model.Base.Sku.Sku'.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.SkuPrice
where

import           Control.DeepSeq (NFData)
import           Data.Data       (Data, Typeable)
import           Data.Text       (Text)
import           Data.Time       (Day)
import           GHC.Generics    (Generic)
import           Web.Skroutz.TH

data SkuPrice = SkuPrice {
    _skuPriceDate     :: Day
  , _skuPricePrice    :: Double
  , _skuPriceShopName :: Maybe Text
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''SkuPrice "_skuPrice"
