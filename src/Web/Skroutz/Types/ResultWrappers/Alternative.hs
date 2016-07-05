{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ResultWrappers.Alternative
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Alternative' type.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ResultWrappers.Alternative
where

import           Data.Text      (Text)
import           GHC.Generics   (Generic)
import           Web.Skroutz.TH

data AlternativeDrop = AlternativeDrop {
    _alternativeDropToken   :: Text
  , _alternativeDropDropped :: Bool
  } deriving (Generic, Show)

makeLensesAndJSON ''AlternativeDrop "_alternativeDrop"

data Alternative = Alternative {
    _alternativeTerm      :: Text
  , _alternativeCount     :: Int
  , _alternativeImportant :: Bool
  , _alternativeDrop      :: [AlternativeDrop]
  } deriving (Generic, Show)

makeLensesAndJSON ''Alternative "_alternative"
