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
-- Portability :  non-portable
--
-- Provides the 'MultipleShopReviewResponse' type, to collect results of 'ShopReview' type.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ResultWrappers.ShopReview
where

import           Control.DeepSeq                       (NFData)
import           Data.Data                             (Data, Typeable)
import           GHC.Generics                          (Generic)
import           Web.Skroutz.Model.Base.ShopReview
import           Web.Skroutz.Model.ResultWrappers.Meta
import           Web.Skroutz.TH

data MultipleShopReviewResponse = MultipleShopReviewResponse {
    _multipleShopReviewResponseReviews :: [ShopReview]
  , _multipleShopReviewResponseMeta    :: Meta
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''MultipleShopReviewResponse "_multipleShopReviewResponse"
