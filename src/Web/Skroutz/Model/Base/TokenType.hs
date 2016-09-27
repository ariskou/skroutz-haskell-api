{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DeriveDataTypeable    #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TemplateHaskell       #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.TokenType
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'TokenType' type, a type representing the supported types of 'Token'.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.TokenType
where

import           Control.DeepSeq  (NFData)
import qualified Data.Aeson       as Aeson
import           Data.Aeson.Types (typeMismatch)
import           Data.Data        (Data, Typeable)
import           GHC.Generics     (Generic)
import           Web.Skroutz.TH

data TokenType = TokenTypeBearer
  deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndPrisms ''TokenType

instance Aeson.FromJSON TokenType where
  parseJSON value@(Aeson.String uri) =
    case uri of
      "bearer" -> return TokenTypeBearer
      _ -> typeMismatch "TokenType" value
  parseJSON invalid = typeMismatch "TokenType" invalid

instance Aeson.ToJSON TokenType where
  toJSON TokenTypeBearer = Aeson.String "bearer"
