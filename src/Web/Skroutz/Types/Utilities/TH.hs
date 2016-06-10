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
    dropAndCamelcaseToUnderscoreDefaultOptions
  ) where

import Data.Aeson.Types

dropAndCamelcaseToUnderscoreDefaultOptions :: String -> Options
dropAndCamelcaseToUnderscoreDefaultOptions prefix = defaultOptions {
    fieldLabelModifier = camelTo2 '_' . drop (length prefix)
  }
