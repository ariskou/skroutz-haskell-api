{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ResultWrappers.Autocomplete
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Autocomplete' type.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ResultWrappers.Autocomplete
where

import           Data.Text      (Text)
import           GHC.Generics   (Generic)
import           Web.Skroutz.TH

data AutocompleteD = AutocompleteD {
    _autocompleteDN  :: Text
  , _autocompleteDId :: Int
  } deriving (Generic, Show)

makeLensesAndJSON ''AutocompleteD "_autocompleteD"

data Autocomplete = Autocomplete {
    _autocompleteK :: Text
  , _autocompleteD :: Maybe AutocompleteD
  } deriving (Generic, Show)

makeLensesAndJSON ''Autocomplete "_autocomplete"
