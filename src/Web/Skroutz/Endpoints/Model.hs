{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Model
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Skroutz API endpoints/methods for normal data retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Model
(
  module X
)
where

import           Web.Skroutz.Endpoints.Model.Autocomplete        as X
import           Web.Skroutz.Endpoints.Model.Category            as X
import           Web.Skroutz.Endpoints.Model.Common              as X
import           Web.Skroutz.Endpoints.Model.FilterGroup         as X
import           Web.Skroutz.Endpoints.Model.Flag                as X
import           Web.Skroutz.Endpoints.Model.GeneralSearchResult as X
import           Web.Skroutz.Endpoints.Model.Manufacturer        as X
import           Web.Skroutz.Endpoints.Model.Product             as X
import           Web.Skroutz.Endpoints.Model.Shop                as X
import           Web.Skroutz.Endpoints.Model.Sku                 as X
import           Web.Skroutz.Endpoints.Model.User                as X
