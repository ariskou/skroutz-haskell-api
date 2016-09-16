{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Types.Autocomplete
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Skroutz API endpoints/methods for 'Web.Skroutz.Model.Base.Autocomplete' retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Types.Autocomplete
where

import           Data.Proxy                         (Proxy (..))
import           Data.Text                          (Text)
import           Servant.API
import           Servant.Client
import           Web.Skroutz.Endpoints.Types.Common
import           Web.Skroutz.Model

type AutocompleteAPI =
        "autocomplete" :> Capture "q" Text :> DataAPIMethod MultipleAutocompleteResponse

autocompleteAPI :: Proxy AutocompleteAPI
autocompleteAPI = Proxy

getAutocompletes :: Text -> StandardDataParams MultipleAutocompleteResponse

getAutocompletes = client autocompleteAPI
