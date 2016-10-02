{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Model.Product
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :  non-portable
--
-- Provides the Skroutz API endpoints/methods for 'Product' retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Model.Product
where

import           Data.Proxy                         (Proxy (..))
import           Data.Text                          (Text)
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Endpoints.Model.Common
import           Web.Skroutz.Model

type ProductAPI =
        "products" :> Capture "product_id" Int :> DataAPIMethod SingleProductResponse
  :<|>  "shops" :> Capture "shop_id" Int :> "products" :>  "search" :> QueryParam "shop_uid" Text :> DataAPIMethodPaged MultipleProductResponse

productAPI :: Proxy ProductAPI
productAPI = Proxy

getProduct :: Int -> StandardDataParams SingleProductResponse

getShopProducts :: Int -> Maybe Text -> StandardDataParamsPaged MultipleProductResponse

getProduct :<|> getShopProducts = client productAPI
