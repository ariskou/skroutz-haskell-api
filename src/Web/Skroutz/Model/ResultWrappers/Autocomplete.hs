{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.ResultWrappers.Autocomplete
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability : non-portable
--
-- Provides the 'Autocomplete' type.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ResultWrappers.Autocomplete
where

import           Control.DeepSeq                     (NFData)
import           Data.Data                           (Data, Typeable)
import           GHC.Generics                        (Generic)
import           Web.Skroutz.Model.Base.Autocomplete
import           Web.Skroutz.TH

data MultipleAutocompleteResponse = MultipleAutocompleteResponse {
    _multipleAutocompleteResponseAutocomplete :: [Autocomplete]
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''MultipleAutocompleteResponse "_multipleAutocompleteResponse"
