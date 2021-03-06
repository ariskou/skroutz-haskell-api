{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.Sku
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :  non-portable
--
-- Provides the 'Sku' type, where SKU (Stock Keeping Unit) is an aggregation of
-- 'Product's.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.Sku
where

import           Control.DeepSeq                     (NFData)
import           Data.Data                           (Data, Typeable)
import           Data.Text                           (Text)
import           GHC.Generics                        (Generic)
import           Web.Skroutz.Model.Base.Manufacturer
import           Web.Skroutz.Model.Base.Product
import           Web.Skroutz.Model.Base.SkuImages
import           Web.Skroutz.Model.Base.SkuShopInfo
import           Web.Skroutz.Model.Base.URI
import           Web.Skroutz.TH

data Sku = Sku {
    _skuId                   :: Int
  , _skuEan                  :: Text
  , _skuPn                   :: Text
  , _skuName                 :: Text
  , _skuCategoryId           :: Int
  , _skuFirstProductShopInfo :: Maybe SkuShopInfo
  , _skuClickUrl             :: Maybe URI
  , _skuPriceMax             :: Double
  , _skuPriceMin             :: Double
  , _skuReviewscore          :: Double
  , _skuShopCount            :: Int
  , _skuPlainSpecSummary     :: Text
  , _skuManufacturerId       :: Maybe Int
  , _skuFuture               :: Bool
  , _skuReviewsCount         :: Int
  , _skuVirtual              :: Bool
  , _skuImages               :: SkuImages
  , _skuWebUri               :: URI
  , _skuProducts             :: Maybe [Product]
  , _skuManufacturer         :: Maybe Manufacturer
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''Sku "_sku"
