{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.ResultWrappers.Sku
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Sku' type, where SKU (Stock Keeping Unit) is an aggregation of products.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ResultWrappers.Sku
where

import           Control.DeepSeq                       (NFData)
import           Data.Data                             (Data, Typeable)
import           GHC.Generics                          (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Model.Base.Sku
import           Web.Skroutz.Model.ResultWrappers.Meta

data SingleSkuResponse = SingleSkuResponse {
    _singleSkuResponseSku :: Sku
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''SingleSkuResponse "_singleSkuResponse"

data MultipleSkuResponse = MultipleSkuResponse {
    _multipleSkuResponseSkus :: [Sku]
  , _multipleSkuResponseMeta :: Meta
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''MultipleSkuResponse "_multipleSkuResponse"
