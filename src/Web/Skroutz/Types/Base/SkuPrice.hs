{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.Base.SkuPrice
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'SkuPrice' type, the price of an 'SKU'.
----------------------------------------------------------------------------
module Web.Skroutz.Types.Base.SkuPrice
where

import           Data.Text      (Text)
import           GHC.Generics   (Generic)
import           Web.Skroutz.TH

data SkuPrice = SkuPrice {
    _skuPriceDate     :: Text
  , _skuPricePrice    :: Double
  , _skuPriceShopName :: Maybe Text
  } deriving (Generic, Show)

makeLensesAndJSON ''SkuPrice "_skuPrice"