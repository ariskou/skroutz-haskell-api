{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ResultWrappers.SkuReview
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'SkuReview' type, a user review of an 'SKU'.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ResultWrappers.SkuReview
where

import           GHC.Generics                          (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Base.SkuReview
import           Web.Skroutz.Types.ResultWrappers.Meta

data MultipleSkuReviewResponse = MultipleSkuReviewResponse {
    _multipleSkuReviewResponseReviews :: [SkuReview]
  , _multipleSkuReviewResponseMeta    :: Meta
  } deriving (Generic, Show)

makeLensesAndJSON ''MultipleSkuReviewResponse "_multipleSkuReviewResponse"
