----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.TH
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides utility functions for generating the TemplateHaskell-based fields.
----------------------------------------------------------------------------
module Web.Skroutz.TH
  (
    makeLensesAndJSON
  ) where

import           Control.Lens        (makeLenses)
import           Data.Aeson.TH
import           Data.Aeson.Types    (camelTo2)
import           Data.List           (stripPrefix)
import           Data.Maybe          (fromMaybe)
import           Language.Haskell.TH (Dec, Name, Q)

customDefaultOptions :: String -> Options
customDefaultOptions prefix = defaultOptions {
    -- drop the prefix and then convert came case into underscore-separated naming convention.
    fieldLabelModifier = \fieldName -> camelTo2 '_' $ fromMaybe fieldName (stripPrefix prefix fieldName)
  }

makeLensesAndJSON :: Name -> String -> Q [Dec]
makeLensesAndJSON typeName prefix = do
  lenses <- makeLenses typeName
  jsonInstances <- deriveJSON (customDefaultOptions prefix) typeName
  return $ lenses ++ jsonInstances
