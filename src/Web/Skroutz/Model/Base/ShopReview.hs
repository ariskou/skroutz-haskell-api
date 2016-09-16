{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.ShopReview
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'ShopReview' type, a user review of a shop.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.ShopReview
where

import           Control.DeepSeq (NFData)
import           Data.Data       (Data, Typeable)
import           Data.Text       (Text)
import           GHC.Generics    (Generic)
import           Web.Skroutz.TH

data ShopReview = ShopReview {
    _shopReviewId        :: Int
  , _shopReviewUserId    :: Int
  , _shopReviewReview    :: Text
  , _shopReviewRating    :: Int
  , _shopReviewShopReply :: Maybe Text
  , _shopReviewCreatedAt :: Text
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''ShopReview "_shopReview"
