{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.ResultWrappers.SkuPrice
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'SkuPrice' type, the price of an 'SKU'.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ResultWrappers.SkuPrice
where

import           Control.DeepSeq                 (NFData)
import           Data.Data                       (Data, Typeable)
import           GHC.Generics                    (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Model.Base.SkuPrice

data MultipleSkuPriceResponse = MultipleSkuPriceResponse {
    _multipleSkuPriceResponseAverage :: [SkuPrice]
  , _multipleSkuPriceResponseLowest  ::  [SkuPrice]
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''MultipleSkuPriceResponse "_multipleSkuPriceResponse"

data HistoricalSkuPriceResponse = HistoricalSkuPriceResponse {
    _historicalSkuPriceResponseHistory :: MultipleSkuPriceResponse
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''HistoricalSkuPriceResponse "_historicalSkuPriceResponse"
