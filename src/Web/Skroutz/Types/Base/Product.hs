{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.Base.Product
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Product' type.
----------------------------------------------------------------------------
module Web.Skroutz.Types.Base.Product
where

import           Data.Text                  (Text)
import           GHC.Generics               (Generic)
import           Web.Skroutz.TH

import           Web.Skroutz.Types.Base.URI

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
