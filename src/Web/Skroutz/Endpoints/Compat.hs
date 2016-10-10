{-# LANGUAGE CPP #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Compat
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :  non-portable
--
-- Allows for support of backwards-incompatible versions of the servant library.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Compat
where

import           Network.HTTP.Client        (Manager)
import           Servant.Client             (ServantError)
import           Servant.Common.BaseUrl     (BaseUrl)

#if MIN_VERSION_servant(0,9,0)
import           Servant.Client             (ClientEnv (..), ClientM, runClientM)
#else
import           Control.Monad.Trans.Except (ExceptT, runExceptT)
#endif

#if MIN_VERSION_servant(0,9,0)
type APIWrapper a = ClientM a
#else
type APIWrapper a = Manager -> BaseUrl -> ExceptT ServantError IO a
#endif

runAPIMethod :: Manager -> BaseUrl -> APIWrapper a -> IO (Either ServantError a)
#if MIN_VERSION_servant(0,9,0)
runAPIMethod manager baseUrl apiMethod = runClientM apiMethod (ClientEnv manager baseUrl)
#else
runAPIMethod manager baseUrl apiMethod = runExceptT $ apiMethod manager baseUrl
#endif
