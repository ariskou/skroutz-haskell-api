{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
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

import           Control.DeepSeq (NFData)
import           Data.Data       (Data, Typeable)
import           Data.Text       (Text)
import           GHC.Generics    (Generic)
import           Web.Skroutz.TH

data SkuSpecificationsGroup = SkuSpecificationsGroup {
    _skuSpecificationsGroupId    :: Int
  , _skuSpecificationsGroupName  :: Text
  , _skuSpecificationsGroupOrder :: Int
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''SkuSpecificationsGroup "_skuSpecificationsGroup"

data SkuSpecification = SkuSpecification {
    _skuSpecificationId      :: Int
  , _skuSpecificationName    :: Text
  , _skuSpecificationUnit    :: Text
  , _skuSpecificationValues  :: [Text]
  , _skuSpecificationGroupId :: Maybe Int
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''SkuSpecification "_skuSpecification"
