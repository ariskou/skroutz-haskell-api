{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DeriveDataTypeable    #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.FilterGroupType
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'FilterGroupType' type, a type representing the possible types of filters in 'FilterGroup'.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.FilterGroupType
where

import           Control.DeepSeq  (NFData)
import qualified Data.Aeson       as Aeson
import           Data.Aeson.Types (typeMismatch)
import           Data.Data        (Data, Typeable)
import           GHC.Generics     (Generic)
import           Web.Skroutz.TH


data FilterGroupType = FilterGroupTypePrice | FilterGroupTypeKeyword | FilterGroupTypeSpec | FilterGroupTypeSyncedSpec | FilterGroupTypeCustomRange | FilterGroupTypeSizes
  deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndPrisms ''FilterGroupType

instance Aeson.FromJSON FilterGroupType where
  parseJSON (Aeson.Number 0) = return FilterGroupTypePrice
  parseJSON (Aeson.Number 1) = return FilterGroupTypeKeyword
  parseJSON (Aeson.Number 2) = return FilterGroupTypeSpec
  parseJSON (Aeson.Number 3) = return FilterGroupTypeSyncedSpec
  parseJSON (Aeson.Number 4) = return FilterGroupTypeCustomRange
  parseJSON (Aeson.Number 5) = return FilterGroupTypeSizes
  parseJSON invalid          = typeMismatch "FilterGroupType" invalid

instance Aeson.ToJSON FilterGroupType where
  toJSON FilterGroupTypePrice       = Aeson.Number 0
  toJSON FilterGroupTypeKeyword     = Aeson.Number 1
  toJSON FilterGroupTypeSpec        = Aeson.Number 2
  toJSON FilterGroupTypeSyncedSpec  = Aeson.Number 3
  toJSON FilterGroupTypeCustomRange = Aeson.Number 4
  toJSON FilterGroupTypeSizes       = Aeson.Number 5
