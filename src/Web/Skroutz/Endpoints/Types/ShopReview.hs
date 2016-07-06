{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Types.ShopReview
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Skroutz API endpoints/methods for 'Web.Skroutz.Types.Base.ShopReview' retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Types.ShopReview
where

import           Data.Proxy                         (Proxy (..))
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Endpoints.Types.Common
import           Web.Skroutz.Types

type ShopReviewAPI =
        "shops" :> Capture "shops_id" Int :> "reviews" :> DataAPIMethodPaged MultipleShopReviewResponse

shopReviewAPI :: Proxy ShopReviewAPI
shopReviewAPI = Proxy

getShopReviews :: Int -> StandardDataParamsPaged MultipleShopReviewResponse

getShopReviews = client shopReviewAPI
