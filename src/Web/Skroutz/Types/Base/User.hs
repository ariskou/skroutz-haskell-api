{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.Base.User
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'User' type, an authenticated user.
----------------------------------------------------------------------------
module Web.Skroutz.Types.Base.User
where

import           Data.Text                  (Text)
import           GHC.Generics               (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Base.URI

data User = User {
    _userId       :: Int
  , _userUsername :: Text
  , _userName     :: Text
  , _userSex      :: Text
  , _userAvatar   :: URI
  } deriving (Generic, Show)

makeLensesAndJSON ''User "_user"
