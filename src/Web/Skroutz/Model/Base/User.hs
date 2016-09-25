{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.User
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'User' type, an authenticated user.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.User
where

import           Control.DeepSeq                (NFData)
import           Data.Data                      (Data, Typeable)
import           Data.Text                      (Text)
import           GHC.Generics                   (Generic)
import           Web.Skroutz.Model.Base.URI
import           Web.Skroutz.Model.Base.UserSex
import           Web.Skroutz.TH

data User = User {
    _userId       :: Int
  , _userUsername :: Text
  , _userName     :: Text
  , _userSex      :: UserSex
  , _userAvatar   :: URI
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''User "_user"
