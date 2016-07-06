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

import           GHC.Generics                        (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Base.Autocomplete

data MultipleAutocompleteResponse = MultipleAutocompleteResponse {
    _multipleAutocompleteResponseAutocomplete :: [Autocomplete]
  } deriving (Generic, Show)

makeLensesAndJSON ''MultipleAutocompleteResponse "_multipleAutocompleteResponse"
