{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
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

import           Data.Text
import           GHC.Generics           (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Meta
import           Web.Skroutz.Types.URI

data Category = Category {
    _categoryId                 :: Int
  , _categoryName               :: Text
  , _categoryChildrenCount      :: Int
  , _categoryImageUrl           :: URI
  , _categoryParentId           :: Int
  , _categoryFashion            :: Bool
  , _categoryLayoutMode         :: Text
  , _categoryWebUri             :: URI
  , _categoryCode               :: Text
  , _categoryPath               :: Text
  , _categoryShowSpecifications :: Bool
  , _categoryManufacturerTitle  :: Text
  } deriving (Generic, Show)

makeLensesAndJSON ''Category "_category"

data SingleCategoryResponse = SingleCategoryResponse {
    _singleCategoryResponseCategory :: Category
  } deriving (Generic, Show)

makeLensesAndJSON ''SingleCategoryResponse "_singleCategoryResponse"

data MultipleCategoryResponse = MultipleCategoryResponse {
    _multipleCategoryResponseCategories :: [Category]
  , _multipleCategoryResponseMeta       :: Meta
  } deriving (Generic, Show)

makeLensesAndJSON ''MultipleCategoryResponse "_multipleCategoryResponse"
