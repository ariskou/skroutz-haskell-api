{-# LANGUAGE DeriveGeneric #-}
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
import Data.Text

data Category = Category {
    _categoryIdentifier :: Int
  , _categoryName :: Text
  , _categoryChildrenCount :: Int
  , _categoryImageUrl :: Text
  , _categoryParentId :: Int
  , _categoryFashion :: Bool
  , _categoryLayoutMode :: Text
  , _categoryWebUri :: Text
  , _categoryCode :: Text
  , _categoryPath :: Text
  , _categoryShowSpecifications :: Bool
  , _categoryManufacturerTitle :: Text
  } deriving (Generic, Show)
