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
  , makeLensesAndJSONSumType
  ) where

import           Control.Lens        (makeLenses, makePrisms)
import           Data.Aeson.TH
import           Data.Aeson.Types    (camelTo2)
import           Data.List           (stripPrefix)
import           Data.Maybe          (fromMaybe)
import           Language.Haskell.TH (Dec, Name, Q)

customDefaultOptions :: String -> String -> Options
customDefaultOptions fieldPrefix constructorPrefix = defaultOptions {
    -- drop the prefix and then convert came case into underscore-separated naming convention.
    fieldLabelModifier = \fieldName -> camelTo2 '_' $ fromMaybe fieldName (stripPrefix fieldPrefix fieldName)
    -- we really only need support for sum types with nullary constructors in this library.
  , constructorTagModifier = \constructorName -> camelTo2 '_'$ fromMaybe constructorName (stripPrefix constructorPrefix constructorName)
  }

makeLensesAndJSON :: Name -> String -> Q [Dec]
makeLensesAndJSON typeName prefix = do
  lenses <- makeLenses typeName
  prisms <- makePrisms typeName
  jsonInstances <- deriveJSON (customDefaultOptions prefix "") typeName
  return $ lenses ++ prisms ++ jsonInstances

makeLensesAndJSONSumType :: Name -> String -> String -> Q [Dec]
makeLensesAndJSONSumType typeName fieldPrefix constructorPrefix = do
  lenses <- makeLenses typeName
  prisms <- makePrisms typeName
  jsonInstances <- deriveJSON (customDefaultOptions fieldPrefix constructorPrefix) typeName
  return $ lenses ++ prisms ++ jsonInstances
