{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Types.Product
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Skroutz API endpoints/methods for 'Web.Skroutz.Types.Base.Product' retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Types.Product
where

import           Data.Proxy                         (Proxy (..))
import           Data.Text                          (Text)
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Endpoints.Types.Common
import           Web.Skroutz.Types

type ProductAPI =
        "products" :> Capture "product_id" Int :> DataAPIMethod SingleProductResponse
  :<|>  "shops" :> Capture "shop_id" Int :> "products" :>  "search" :> QueryParam "shop_uid" Text :> DataAPIMethodPaged MultipleProductResponse

productAPI :: Proxy ProductAPI
productAPI = Proxy

getProduct :: Int -> StandardDataParams SingleProductResponse

getShopProducts :: Int -> Maybe Text -> StandardDataParamsPaged MultipleProductResponse

getProduct :<|> getShopProducts = client productAPI
