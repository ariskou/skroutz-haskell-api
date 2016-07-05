{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ResultWrappers.Category
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Category' type, a category of products.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ResultWrappers.Category
where

import           GHC.Generics                          (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Base.Category
import           Web.Skroutz.Types.ResultWrappers.Meta

data SingleCategoryResponse = SingleCategoryResponse {
    _singleCategoryResponseCategory :: Category
  } deriving (Generic, Show)

makeLensesAndJSON ''SingleCategoryResponse "_singleCategoryResponse"

data MultipleCategoryResponse = MultipleCategoryResponse {
    _multipleCategoryResponseCategories :: [Category]
  , _multipleCategoryResponseMeta       :: Meta
  } deriving (Generic, Show)

makeLensesAndJSON ''MultipleCategoryResponse "_multipleCategoryResponse"
