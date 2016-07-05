{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.Token
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Token' type, the access token required to access the API.
----------------------------------------------------------------------------
module Web.Skroutz.Types.Token
where

import           Data.Text      (Text)
import           GHC.Generics   (Generic)
import           Web.Skroutz.TH

data Token = Token {
    _tokenAccessToken :: Text
  , _tokenTokenType   :: Text
  , _tokenExpiresIn   :: Int
  } deriving (Generic, Show)

makeLensesAndJSON ''Token "_token"
