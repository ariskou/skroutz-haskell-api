{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Auth
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Skroutz API endpoints/methods for authentication and token generation.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Auth
where

import           Control.Monad.Trans.Except (ExceptT)
import           Data.Proxy                 (Proxy (..))
import           Data.Text                  (Text)
import           Network.HTTP.Client        (Manager, ManagerSettings)
import           Network.HTTP.Client.TLS    (tlsManagerSettings)
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Types          (Token)

type AuthAPI =
       "token"
        :> QueryParam "client_id" Text
        :> QueryParam "client_secret" Text
        :> QueryParam "grant_type" Text
        :> QueryParam "redirect_uri" Text
        :> QueryParam "scope" Text
        :> Post '[JSON] Token

authAPI :: Proxy AuthAPI
authAPI = Proxy

getToken :: Maybe Text -> Maybe Text -> Maybe Text -> Maybe Text  -> Maybe Text -> Manager -> BaseUrl -> ExceptT ServantError IO Token
getToken = client authAPI

defaultAuthManagerSettings :: ManagerSettings
defaultAuthManagerSettings = tlsManagerSettings

defaultAuthBaseUrl :: BaseUrl
defaultAuthBaseUrl = BaseUrl Https "www.skroutz.gr" 443 "/oauth2"

defaultAuthPublicGrantType :: Text
defaultAuthPublicGrantType = "client_credentials"

defaultAuthPublicRedirectUri :: Text
defaultAuthPublicRedirectUri = "http://example.com/auth/skroutz"

defaultAuthPublicScope :: Text
defaultAuthPublicScope = "public"
