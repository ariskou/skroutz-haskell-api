{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.ResultWrappers.ShopReview
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'ShopReview' type, a user review of a shop.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ResultWrappers.ShopReview
where

import           Control.DeepSeq                       (NFData)
import           Data.Data                             (Data, Typeable)
import           GHC.Generics                          (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Model.Base.ShopReview
import           Web.Skroutz.Model.ResultWrappers.Meta

data MultipleShopReviewResponse = MultipleShopReviewResponse {
    _multipleShopReviewResponseReviews :: [ShopReview]
  , _multipleShopReviewResponseMeta    :: Meta
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''MultipleShopReviewResponse "_multipleShopReviewResponse"
