{-# LANGUAGE DeriveGeneric #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.Manufacturer
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Manufacturer' type.
----------------------------------------------------------------------------
module Web.Skroutz.Types.Manufacturer
where

import GHC.Generics (Generic)
import Data.Text

data Manufacturer = Manufacturer {
    _manufacturerIdentifier :: Int
  , _manufacturerName :: Text
  , _manufacturerImageUrl :: Maybe Text
  } deriving (Generic, Show)
