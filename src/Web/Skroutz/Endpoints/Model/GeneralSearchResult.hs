{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Model.GeneralSearchResult
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :  non-portable
--
-- Provides the Skroutz API endpoints/methods for 'MultipleGeneralSearchResultResponse' retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Model.GeneralSearchResult
where

import           Data.Proxy                         (Proxy (..))
import           Data.Text                          (Text)
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Endpoints.Model.Common
import           Web.Skroutz.Model

type GeneralSearchResultAPI =
        "search" :> QueryParam "q" Text :> DataAPIMethodPaged MultipleGeneralSearchResultResponse

generalSearchResultAPI :: Proxy GeneralSearchResultAPI
generalSearchResultAPI = Proxy

getGeneralSearchResult :: Maybe Text -> StandardDataParamsPaged MultipleGeneralSearchResultResponse

getGeneralSearchResult = client generalSearchResultAPI
