{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.Product
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Product' type.
----------------------------------------------------------------------------
module Web.Skroutz.Types.Product
where

import           Data.Text
import           GHC.Generics           (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Meta
import           Web.Skroutz.Types.URI

data Product = Product {
    _productId           :: Int
  , _productName         :: Text
  , _productSkuId        :: Int
  , _productShopId       :: Int
  , _productCategoryId   :: Int
  , _productAvailability :: Text
  , _productClickUrl     :: URI
  , _productShopUid      :: Text
  , _productExpenses     :: Maybe Text --TODO: Check for real type, only null examples offered
  , _productWebUri       :: URI
  , _productPrice        :: Double
  } deriving (Generic, Show)

makeLensesAndJSON ''Product "_product"

data SingleProductResponse = SingleProductResponse {
    _singleProductResponseProduct :: Product
  } deriving (Generic, Show)

makeLensesAndJSON ''SingleProductResponse "_singleProductResponse"

data MultipleProductResponse = MultipleProductResponse {
    _multipleProductResponseCategories :: [Product]
  , _multipleProductResponseMeta       :: Meta
  } deriving (Generic, Show)

makeLensesAndJSON ''MultipleProductResponse "_multipleProductResponse"
