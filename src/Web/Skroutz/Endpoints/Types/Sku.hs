{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Types.Sku
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Skroutz API endpoints/methods for 'Web.Skroutz.Types.Sku' retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Types.Sku
where

import           Data.Proxy                               (Proxy (..))
import           GHC.Generics                             (Generic)
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Endpoints.Types.Common
import           Web.Skroutz.Types

data SkuOrderBy = SkuOrderByPriceVAT | SkuOrderByPopularity | SkuOrderByRating
 deriving (Generic, Show)

instance ToHttpApiData SkuOrderBy where
  toQueryParam SkuOrderByPriceVAT = "pricevat"
  toQueryParam SkuOrderByPopularity = "popularity"
  toQueryParam SkuOrderByRating = "rating"

data SkuOrderDir = SkuOrderDirAscending | SkuOrderDirDescending
 deriving (Generic, Show)

instance ToHttpApiData SkuOrderDir where
  toQueryParam SkuOrderDirAscending = "asc"
  toQueryParam SkuOrderDirDescending = "desc"
