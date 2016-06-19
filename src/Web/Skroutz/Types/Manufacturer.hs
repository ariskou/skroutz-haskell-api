{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
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

import           Data.Text
import           GHC.Generics          (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.URI

data Manufacturer = Manufacturer {
    _manufacturerId       :: Int
  , _manufacturerName     :: Text
  , _manufacturerImageUrl :: Maybe URI
  } deriving (Generic, Show)

makeLensesAndJSON ''Manufacturer "_manufacturer"
