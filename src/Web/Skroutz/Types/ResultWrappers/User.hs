{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
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

import           Control.DeepSeq             (NFData)
import           Data.Data                   (Data, Typeable)
import           GHC.Generics                (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Base.User

data SingleUserResponse = SingleUserResponse {
    _singleUserResponseUser :: User
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''SingleUserResponse "_singleUserResponse"
