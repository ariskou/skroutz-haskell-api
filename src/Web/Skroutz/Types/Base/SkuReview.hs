{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.Base.SkuReview
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'SkuReview' type, a user review of an 'SKU'.
----------------------------------------------------------------------------
module Web.Skroutz.Types.Base.SkuReview
where

import           Data.Text              (Text)
import           GHC.Generics           (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Base.Meta

data SkuReview = SkuReview {
    _skuReviewId                :: Int
  , _skuReviewUserId            :: Int
  , _skuReviewReview            :: Text
  , _skuReviewRating            :: Int
  , _skuReviewCreatedAt         :: Text
  , _skuReviewDemoted           :: Bool
  , _skuReviewVotesCount        :: Int
  , _skuReviewHelpfulVotesCount :: Int
  } deriving (Generic, Show)

makeLensesAndJSON ''SkuReview "_skuReview"

data MultipleSkuReviewResponse = MultipleSkuReviewResponse {
    _multipleSkuReviewResponseReviews :: [SkuReview]
  , _multipleSkuReviewResponseMeta    :: Meta
  } deriving (Generic, Show)

makeLensesAndJSON ''MultipleSkuReviewResponse "_multipleSkuReviewResponse"
