{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Types.Flag
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Skroutz API endpoints/methods for 'Web.Skroutz.Types.Base.Flag' retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Types.Flag
where

import           Data.Proxy                         (Proxy (..))
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Endpoints.Types.Common
import           Web.Skroutz.Types

type FlagAPI =
        "api" :> "flags" :> DataAPIMethod MultipleFlagResponse

flagAPI :: Proxy FlagAPI
flagAPI = Proxy

getFlags :: StandardDataParams MultipleFlagResponse

getFlags = client flagAPI
