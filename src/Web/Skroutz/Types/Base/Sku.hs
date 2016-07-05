{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.Base.Sku
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Sku' type, where SKU (Stock Keeping Unit) is an aggregation of products.
----------------------------------------------------------------------------
module Web.Skroutz.Types.Base.Sku
where

import           Data.Text                      (Text)
import           GHC.Generics                   (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Base.Manufacturer
import           Web.Skroutz.Types.Base.Meta
import           Web.Skroutz.Types.Base.Product
import           Web.Skroutz.Types.Base.SkuImages
import           Web.Skroutz.Types.Base.URI

data Sku = Sku {
    _skuId                   :: Int
  , _skuEan                  :: Text
  , _skuPn                   :: Text
  , _skuName                 :: Text
  , _skuCategoryId           :: Int
  , _skuFirstProductShopInfo :: Maybe Text
  , _skuClickUrl             :: Maybe URI
  , _skuPriceMax             :: Double
  , _skuPriceMin             :: Double
  , _skuReviewscore          :: Double
  , _skuShopCount            :: Int
  , _skuPlainSpecSummary     :: Text
  , _skuManufacturerId       :: Int
  , _skuFuture               :: Bool
  , _skuReviewsCount         :: Int
  , _skuVirtual              :: Bool
  , _skuImages               :: SkuImages
  , _skuWebUri               :: URI
  , _skuProducts             :: Maybe [Product]
  , _skuManufacturer         :: Maybe Manufacturer
  } deriving (Generic, Show)

makeLensesAndJSON ''Sku "_sku"

data SingleSkuResponse = SingleSkuResponse {
    _singleSkuResponseSku :: Sku
  } deriving (Generic, Show)

makeLensesAndJSON ''SingleSkuResponse "_singleSkuResponse"

data MultipleSkuResponse = MultipleSkuResponse {
    _multipleSkuResponseSkus :: [Sku]
  , _multipleSkuResponseMeta :: Meta
  } deriving (Generic, Show)

makeLensesAndJSON ''MultipleSkuResponse "_multipleSkuResponse"
