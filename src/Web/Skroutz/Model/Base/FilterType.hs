{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DeriveDataTypeable    #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.FilterType
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'FilterType' type, a type representing the possible types of filters in 'FilterGroup'.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.FilterType
where

import           Control.DeepSeq  (NFData)
import qualified Data.Aeson       as Aeson
import           Data.Aeson.Types (typeMismatch)
import           Data.Data        (Data, Typeable)
import           GHC.Generics     (Generic)
import           Web.Skroutz.TH


data FilterType = FilterTypePrice | FilterTypeKeyword | FilterTypeSpec | FilterTypeSyncedSpec | FilterTypeCustomRange | FilterTypeSizes
  deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndPrisms ''FilterType

instance Aeson.FromJSON FilterType where
  parseJSON (Aeson.Number 0) = return FilterTypePrice
  parseJSON (Aeson.Number 1) = return FilterTypeKeyword
  parseJSON (Aeson.Number 2) = return FilterTypeSpec
  parseJSON (Aeson.Number 3) = return FilterTypeSyncedSpec
  parseJSON (Aeson.Number 4) = return FilterTypeCustomRange
  parseJSON (Aeson.Number 5) = return FilterTypeSizes
  parseJSON invalid = typeMismatch "FilterType" invalid

instance Aeson.ToJSON FilterType where
  toJSON FilterTypePrice = Aeson.Number 0
  toJSON FilterTypeKeyword = Aeson.Number 1
  toJSON FilterTypeSpec = Aeson.Number 2
  toJSON FilterTypeSyncedSpec = Aeson.Number 3
  toJSON FilterTypeCustomRange = Aeson.Number 4
  toJSON FilterTypeSizes = Aeson.Number 5
