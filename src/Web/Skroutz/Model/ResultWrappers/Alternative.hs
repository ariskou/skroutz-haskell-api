{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.ResultWrappers.Alternative
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability : non-portable
--
-- Provides the 'Alternative' and 'AlternativeDrop' types, used in search results.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ResultWrappers.Alternative
where

import           Control.DeepSeq (NFData)
import           Data.Data       (Data, Typeable)
import           Data.Text       (Text)
import           GHC.Generics    (Generic)
import           Web.Skroutz.TH

data AlternativeDrop = AlternativeDrop {
    _alternativeDropToken   :: Text
  , _alternativeDropDropped :: Bool
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''AlternativeDrop "_alternativeDrop"

data Alternative = Alternative {
    _alternativeTerm      :: Text
  , _alternativeCount     :: Maybe Int
  , _alternativeImportant :: Bool
  , _alternativeDrop      :: Maybe [AlternativeDrop]
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''Alternative "_alternative"
