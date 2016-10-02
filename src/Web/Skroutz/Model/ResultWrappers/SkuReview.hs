{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.ResultWrappers.SkuReview
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability : non-portable
--
-- Provides the 'MultipleSkuReviewResponse' type, to collect results of 'SkuReview' type.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ResultWrappers.SkuReview
where

import           Control.DeepSeq                       (NFData)
import           Data.Data                             (Data, Typeable)
import           GHC.Generics                          (Generic)
import           Web.Skroutz.Model.Base.SkuReview
import           Web.Skroutz.Model.ResultWrappers.Meta
import           Web.Skroutz.TH

data MultipleSkuReviewResponse = MultipleSkuReviewResponse {
    _multipleSkuReviewResponseReviews :: [SkuReview]
  , _multipleSkuReviewResponseMeta    :: Meta
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''MultipleSkuReviewResponse "_multipleSkuReviewResponse"
