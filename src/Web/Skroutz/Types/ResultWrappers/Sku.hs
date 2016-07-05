{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ResultWrappers.Sku
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Sku' type, where SKU (Stock Keeping Unit) is an aggregation of products.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ResultWrappers.Sku
where

import           GHC.Generics                          (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Base.Sku
import           Web.Skroutz.Types.ResultWrappers.Meta

data SingleSkuResponse = SingleSkuResponse {
    _singleSkuResponseSku :: Sku
  } deriving (Generic, Show)

makeLensesAndJSON ''SingleSkuResponse "_singleSkuResponse"

data MultipleSkuResponse = MultipleSkuResponse {
    _multipleSkuResponseSkus :: [Sku]
  , _multipleSkuResponseMeta :: Meta
  } deriving (Generic, Show)

makeLensesAndJSON ''MultipleSkuResponse "_multipleSkuResponse"
