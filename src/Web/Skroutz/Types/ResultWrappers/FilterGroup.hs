{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ResultWrappers.FilterGroup
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'FilterGroup' type.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ResultWrappers.FilterGroup
where

import           Data.Text              (Text)
import           GHC.Generics           (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.ResultWrappers.Meta
import           Web.Skroutz.Types.Base.FilterGroup

data MultipleFilterGroupResponse = MultipleFilterGroupResponse {
    _multipleFilterGroupResponseFilterGroups :: [FilterGroup]
  , _multipleFilterGroupResponseMeta         :: Meta
  } deriving (Generic, Show)

makeLensesAndJSON ''MultipleFilterGroupResponse "_multipleFilterGroupResponse"
