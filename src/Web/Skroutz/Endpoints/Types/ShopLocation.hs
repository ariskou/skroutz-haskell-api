{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Types.ShopLocation
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Skroutz API endpoints/methods for 'Web.Skroutz.Types.ShopLocation' retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Types.ShopLocation
where

import           Data.Proxy                         (Proxy (..))
import           GHC.Generics                       (Generic)
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Endpoints.Types.Common
import           Web.Skroutz.Types

data ShopLocationEmbed = ShopLocationEmbedAddress
 deriving (Generic, Show)

instance ToHttpApiData ShopLocationEmbed where
  toQueryParam ShopLocationEmbedAddress = "address"

type ShopLocationAPI =
        "shops" :> Capture "shops_id" Int :> "locations" :> QueryParam "embed" ShopLocationEmbed :> DataAPIMethod MultipleShopLocationResponse
  :<|>  "shops" :> Capture "shops_id" Int :> "locations" :> Capture "shoplocation_id" Int :> QueryParam "embed" ShopLocationEmbed :> DataAPIMethod SingleShopLocationResponse

shopLocationAPI :: Proxy ShopLocationAPI
shopLocationAPI = Proxy

getShopLocations :: Int -> Maybe ShopLocationEmbed -> StandardDataParams MultipleShopLocationResponse

getShopLocation :: Int -> Int -> Maybe ShopLocationEmbed -> StandardDataParams SingleShopLocationResponse

getShopLocations :<|> getShopLocation = client shopLocationAPI
