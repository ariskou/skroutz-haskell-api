{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ResultWrappers.User
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'User' type, used to mark user provided content as requiring attention/moderation.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ResultWrappers.User
where

import           GHC.Generics                (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Base.User

data SingleUserResponse = SingleUserResponse {
    _singleUserResponseUser :: User
  } deriving (Generic, Show)

makeLensesAndJSON ''SingleUserResponse "_singleUserResponse"
