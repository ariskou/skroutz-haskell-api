{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.Category
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Category' type, a category of products.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.Category
where

import           Control.DeepSeq                     (NFData)
import           Data.Data                           (Data, Typeable)
import           Data.Text                           (Text)
import           GHC.Generics                        (Generic)
import           Web.Skroutz.Model.Base.CategoryPath
import           Web.Skroutz.Model.Base.LayoutMode
import           Web.Skroutz.Model.Base.URI
import           Web.Skroutz.TH

data Category = Category {
    _categoryId                 :: Int
  , _categoryName               :: Text
  , _categoryChildrenCount      :: Int
  , _categoryImageUrl           :: URI
  , _categoryParentId           :: Int
  , _categoryFashion            :: Bool
  , _categoryLayoutMode         :: LayoutMode
  , _categoryWebUri             :: URI
  , _categoryCode               :: Text
  , _categoryPath               :: CategoryPath
  , _categoryShowSpecifications :: Bool
  , _categoryManufacturerTitle  :: Text
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''Category "_category"
