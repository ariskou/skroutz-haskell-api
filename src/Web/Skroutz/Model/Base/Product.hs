{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.Product
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Product' type.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.Product
where

import           Control.DeepSeq            (NFData)
import           Data.Data                  (Data, Typeable)
import           Data.Text                  (Text)
import           GHC.Generics               (Generic)
import           Web.Skroutz.Model.Base.URI
import           Web.Skroutz.TH

data Product = Product {
    _productId           :: Int
  , _productName         :: Text
  , _productSkuId        :: Int
  , _productShopId       :: Int
  , _productCategoryId   :: Int
  , _productAvailability :: Text
  , _productClickUrl     :: URI
  , _productShopUid      :: Text
  , _productExpenses     :: Maybe Double
  , _productWebUri       :: URI
  , _productPrice        :: Double
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''Product "_product"
