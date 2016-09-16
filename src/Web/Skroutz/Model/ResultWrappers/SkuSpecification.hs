{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ResultWrappers.SkuSpecification
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'SkuSpecification' type, the specification of an 'SKU'.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ResultWrappers.SkuSpecification
where

import           Control.DeepSeq                         (NFData)
import           Data.Data                               (Data, Typeable)
import           GHC.Generics                            (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Base.SkuSpecification

data MultipleSkuSpecificationResponse = MultipleSkuSpecificationResponse {
    _multipleSkuSpecificationResponseSpecifications :: [SkuSpecification]
  , _multipleSkuSpecificationResponseGroups         :: Maybe [SkuSpecificationsGroup]
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''MultipleSkuSpecificationResponse "_multipleSkuSpecificationResponse"
