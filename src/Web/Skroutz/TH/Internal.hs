{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.TH.Internal
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides utility functions for generating the TemplateHaskell-based fields.
----------------------------------------------------------------------------
module Web.Skroutz.TH.Internal
where

import Data.Aeson.TH
import Data.Aeson.Types
import Control.Lens (makeFields, makePrisms)
import Language.Haskell.TH

customDefaultOptions :: String -> Options
customDefaultOptions prefix = defaultOptions {
    fieldLabelModifier = \haskellFieldName ->
      -- drop the prefix and then convert came case into underscore-separated naming convention.
      let fieldName = camelTo2 '_' $ Prelude.drop (Prelude.length prefix) haskellFieldName
      -- special case: if the name is "identifier", rename to id in JSON. Used in order to avoid generating a field accessor in Haskell named "id".
      in if fieldName == "identifier" then "id" else fieldName
  }

makeTH :: Name -> String -> Q [Dec]
makeTH typeName prefix = do
  ex1 <- makeFields typeName
  ex2 <- makePrisms typeName
  ex3 <- deriveJSON (customDefaultOptions prefix) typeName
  return $ Prelude.concat [ex1, ex2, ex3]
