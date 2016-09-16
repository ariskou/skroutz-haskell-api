{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Types.Shop
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Skroutz API endpoints/methods for 'Web.Skroutz.Model.Base.Shop' retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Types.Shop
where

import           Data.Proxy                         (Proxy (..))
import           Data.Text                          (Text)
import           GHC.Generics                       (Generic)
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Endpoints.Types.Common
import           Web.Skroutz.Model

data ShopLocationEmbed = ShopLocationEmbedAddress
 deriving (Generic, Show)

instance ToHttpApiData ShopLocationEmbed where
  toQueryParam ShopLocationEmbedAddress = "address"

type ShopAPI =
        "shops" :> Capture "shops_id" Int :> DataAPIMethod SingleShopResponse
  :<|>  "shops" :> "search" :> QueryParam "q" Text :> DataAPIMethodPaged MultipleShopResponse
  :<|>  "shops" :> Capture "shops_id" Int :> "locations" :> QueryParam "embed" ShopLocationEmbed :> DataAPIMethodPaged MultipleShopLocationResponse
  :<|>  "shops" :> Capture "shops_id" Int :> "locations" :> Capture "shoplocation_id" Int :> QueryParam "embed" ShopLocationEmbed :> DataAPIMethod SingleShopLocationResponse
  :<|>  "shops" :> Capture "shops_id" Int :> "reviews" :> DataAPIMethodPaged MultipleShopReviewResponse

shopAPI :: Proxy ShopAPI
shopAPI = Proxy

getShop :: Int -> StandardDataParams SingleShopResponse

getShops :: Maybe Text -> StandardDataParamsPaged MultipleShopResponse

getShopLocations :: Int -> Maybe ShopLocationEmbed -> StandardDataParamsPaged MultipleShopLocationResponse

getShopLocation :: Int -> Int -> Maybe ShopLocationEmbed -> StandardDataParams SingleShopLocationResponse

getShopReviews :: Int -> StandardDataParamsPaged MultipleShopReviewResponse

getShop :<|> getShops :<|> getShopLocations :<|> getShopLocation :<|> getShopReviews = client shopAPI
