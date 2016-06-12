{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.Category
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Category' type, a category of products.
----------------------------------------------------------------------------
module Web.Skroutz.Types.Category
where

import GHC.Generics (Generic)
import Data.Aeson.TH
import Data.Scientific
import Data.Text
import Control.Lens (makeFields, makePrisms)
import Web.Skroutz.Types.Utilities.TH

data Category = Category {
    _categoryIdentifier :: Scientific
  , _categoryName :: Text
  , _categoryChildrenCount :: Scientific
  , _categoryImageUrl :: Text
  , _categoryParentId :: Scientific
  , _categoryFashion :: Bool
  , _categoryLayoutMode :: Text
  , _categoryWebUri :: Text
  , _categoryCode :: Text
  , _categoryPath :: Text
  , _categoryShowSpecifications :: Bool
  , _categoryManufacturerTitle :: Text
  } deriving (Generic, Show)


makeFields ''Category
makePrisms ''Category
deriveJSON (customDefaultOptions "_category") ''Category
