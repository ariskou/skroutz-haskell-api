{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.SkuReview
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability : non-portable
--
-- Provides the 'SkuReview' type, a user review of an 'Web.Skroutz.Model.Base.Sku.Sku'.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.SkuReview
where

import           Control.DeepSeq                    (NFData)
import           Data.Data                          (Data, Typeable)
import           Data.Text                          (Text)
import           GHC.Generics                       (Generic)
import           Web.Skroutz.Model.Base.ISO8601Time
import           Web.Skroutz.TH

data SkuReview = SkuReview {
    _skuReviewId                :: Int
  , _skuReviewUserId            :: Int
  , _skuReviewReview            :: Text
  , _skuReviewRating            :: Int
  , _skuReviewCreatedAt         :: ISO8601Time
  , _skuReviewDemoted           :: Bool
  , _skuReviewVotesCount        :: Int
  , _skuReviewHelpfulVotesCount :: Int
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''SkuReview "_skuReview"
