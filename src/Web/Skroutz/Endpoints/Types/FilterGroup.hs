{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Types.FilterGroup
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Skroutz API endpoints/methods for 'Web.Skroutz.Model.Base.FilterGroup' retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Types.FilterGroup
where

import           Data.Proxy                         (Proxy (..))
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Endpoints.Types.Common
import           Web.Skroutz.Model

type FilterGroupAPI =
        "categories" :> Capture "category_id" Int :> "filter_groups" :> DataAPIMethodPaged MultipleFilterGroupResponse

filterGroupAPI :: Proxy FilterGroupAPI
filterGroupAPI = Proxy

getFilterGroups :: Int -> StandardDataParamsPaged MultipleFilterGroupResponse

getFilterGroups = client filterGroupAPI
