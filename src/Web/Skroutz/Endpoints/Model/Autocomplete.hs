{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Model.Autocomplete
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :  non-portable
--
-- Provides the Skroutz API endpoints/methods for 'Autocomplete' retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Model.Autocomplete
where

import           Data.Proxy                         (Proxy (..))
import           Data.Text                          (Text)
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Endpoints.Model.Common
import           Web.Skroutz.Model

type AutocompleteAPI =
        "autocomplete" :> QueryParam "q" Text :> DataAPIMethod MultipleAutocompleteResponse

autocompleteAPI :: Proxy AutocompleteAPI
autocompleteAPI = Proxy

getAutocompletes :: Maybe Text -> StandardDataParams MultipleAutocompleteResponse

getAutocompletes = client autocompleteAPI
