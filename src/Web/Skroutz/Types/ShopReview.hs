{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ShopReview
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'ShopReview' type, a user review of a shop.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ShopReview
where

import           Data.Text
import           GHC.Generics           (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Meta

data ShopReview = ShopReview {
    _shopReviewId        :: Int
  , _shopReviewUserId    :: Int
  , _shopReviewReview    :: Text
  , _shopReviewRating    :: Int
  , _shopReviewShopReply :: Maybe Text
  , _shopReviewCreatedAt :: Text
  } deriving (Generic, Show)

makeLensesAndJSON ''ShopReview "_shopReview"

data MultipleShopReviewResponse = MultipleShopReviewResponse {
    _multipleShopReviewResponseReviews :: [ShopReview]
  , _multipleShopReviewResponseMeta    :: Meta
  } deriving (Generic, Show)

makeLensesAndJSON ''MultipleShopReviewResponse "_multipleShopReviewResponse"
