{-# LANGUAGE DataKinds         #-}
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
-- Provides the Skroutz API endpoints/methods for 'Web.Skroutz.Types.Base.Shop' retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Types.Shop
where

import           Data.Proxy                         (Proxy (..))
import           Data.Text                          (Text)
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Endpoints.Types.Common
import           Web.Skroutz.Types

type ShopAPI =
        "shops" :> Capture "shops_id" Int :> DataAPIMethod SingleShopResponse
  :<|>  "shops" :> "search" :> QueryParam "q" Text :> DataAPIMethodPaged MultipleShopResponse

shopAPI :: Proxy ShopAPI
shopAPI = Proxy

getShop :: Int -> StandardDataParams SingleShopResponse

getShops :: Maybe Text -> StandardDataParamsPaged MultipleShopResponse

getShop :<|> getShops = client shopAPI
