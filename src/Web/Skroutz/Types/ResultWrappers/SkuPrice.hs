{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ResultWrappers.SkuPrice
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'SkuPrice' type, the price of an 'SKU'.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ResultWrappers.SkuPrice
where

import           GHC.Generics                    (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Base.SkuPrice

data MultipleSkuPriceResponse = MultipleSkuPriceResponse {
    _multipleSkuPriceResponseAverage :: [SkuPrice]
  , _multipleSkuPriceResponseLowest  ::  [SkuPrice]
  } deriving (Generic, Show)

makeLensesAndJSON ''MultipleSkuPriceResponse "_multipleSkuPriceResponse"

data HistoricalSkuPriceResponse = HistoricalSkuPriceResponse {
    _historicalSkuPriceResponseHistory :: MultipleSkuPriceResponse
  } deriving (Generic, Show)

makeLensesAndJSON ''HistoricalSkuPriceResponse "_historicalSkuPriceResponse"