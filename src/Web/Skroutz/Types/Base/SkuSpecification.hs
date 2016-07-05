{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.Base.SkuSpecification
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'SkuSpecification' type, the specification of an 'SKU'.
----------------------------------------------------------------------------
module Web.Skroutz.Types.Base.SkuSpecification
where

import           Data.Text      (Text)
import           GHC.Generics   (Generic)
import           Web.Skroutz.TH

data SkuSpecificationsGroup = SkuSpecificationsGroup {
    _skuSpecificationsGroupId    :: Int
  , _skuSpecificationsGroupName  :: Text
  , _skuSpecificationsGroupOrder :: Int
  } deriving (Generic, Show)

makeLensesAndJSON ''SkuSpecificationsGroup "_skuSpecificationsGroup"

data SkuSpecification = SkuSpecification {
    _skuSpecificationId      :: Int
  , _skuSpecificationName    :: Text
  , _skuSpecificationUnit    :: Text
  , _skuSpecificationValues  :: [Text]
  , _skuSpecificationGroupId :: Maybe Int
  } deriving (Generic, Show)

makeLensesAndJSON ''SkuSpecification "_skuSpecification"
