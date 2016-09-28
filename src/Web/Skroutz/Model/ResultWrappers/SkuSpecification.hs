{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.ResultWrappers.SkuSpecification
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'SkuSpecification' type, the specification of an 'SKU'.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ResultWrappers.SkuSpecification
where

import           Control.DeepSeq                         (NFData)
import           Data.Data                               (Data, Typeable)
import           GHC.Generics                            (Generic)
import           Web.Skroutz.Model.Base.SkuSpecification
import           Web.Skroutz.TH

data MultipleSkuSpecificationResponse = MultipleSkuSpecificationResponse {
    _multipleSkuSpecificationResponseSpecifications :: [SkuSpecification]
  , _multipleSkuSpecificationResponseGroups         :: Maybe [SkuSpecificationsGroup]
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''MultipleSkuSpecificationResponse "_multipleSkuSpecificationResponse"
