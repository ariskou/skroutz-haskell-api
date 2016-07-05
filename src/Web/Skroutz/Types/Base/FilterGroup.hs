{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.Base.FilterGroup
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'FilterGroup' type.
----------------------------------------------------------------------------
module Web.Skroutz.Types.Base.FilterGroup
where

import           Data.Text              (Text)
import           GHC.Generics           (Generic)
import           Web.Skroutz.TH

data FilterGroup = FilterGroup {
    _filterGroupId         :: Int
  , _filterGroupName       :: Text
  , _filterGroupActive     :: Bool
  , _filterGroupCategoryId :: Int
  , _filterGroupCreatedAt  :: Maybe Text
  , _filterGroupUpdatedAt  :: Text
  , _filterGroupHint       :: Text
  , _filterGroupCombined   :: Bool
  , _filterGroupFilterType :: Int
  } deriving (Generic, Show)

makeLensesAndJSON ''FilterGroup "_filterGroup"
