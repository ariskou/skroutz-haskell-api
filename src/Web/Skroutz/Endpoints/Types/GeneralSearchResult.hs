{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Types.GeneralSearchResult
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Skroutz API endpoints/methods for 'Web.Skroutz.Types.ResultWrappers.GeneralSearchResult' retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Types.GeneralSearchResult
where

import           Data.Proxy                         (Proxy (..))
import           Data.Text                          (Text)
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Endpoints.Types.Common
import           Web.Skroutz.Types

type GeneralSearchResultAPI =
        "search" :> Capture "q" Text :> DataAPIMethod MultipleGeneralSearchResultResponse

generalSearchResultAPI :: Proxy GeneralSearchResultAPI
generalSearchResultAPI = Proxy

getGeneralSearchResult :: Text -> StandardDataParams MultipleGeneralSearchResultResponse

getGeneralSearchResult = client generalSearchResultAPI
