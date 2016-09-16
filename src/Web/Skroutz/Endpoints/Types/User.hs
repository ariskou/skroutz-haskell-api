{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Types.User
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Skroutz API endpoints/methods for 'Web.Skroutz.Model.Base.User' retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Types.User
where

import           Data.Proxy                         (Proxy (..))
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Endpoints.Types.Common
import           Web.Skroutz.Model

type UserAPI =
        "user" :> DataAPIMethod SingleUserResponse

userAPI :: Proxy UserAPI
userAPI = Proxy

getUser :: StandardDataParams SingleUserResponse

getUser = client userAPI
