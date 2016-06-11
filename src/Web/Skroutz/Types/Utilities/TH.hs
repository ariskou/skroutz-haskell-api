----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.Utilities.TH
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides utility functions for generating the TemplateHaskell-based fields.
----------------------------------------------------------------------------

module Web.Skroutz.Types.Utilities.TH
  (
    customDefaultOptions
  ) where

import Data.Aeson.Types

customDefaultOptions :: String -> Options
customDefaultOptions prefix = defaultOptions {
    fieldLabelModifier = \haskellFieldName ->
      -- drop the prefix and then convert came case into underscore-separated naming convention.
      let fieldName = camelTo2 '_' $ drop (length prefix) haskellFieldName
      -- special case: if the name is "identifier", rename to id in JSON. Used in order to avoid generating a field accessor in Haskell named "id".
      in if fieldName == "identifier" then "id" else fieldName
  }
