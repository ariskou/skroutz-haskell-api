{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.ResultWrappers.FilterGroup
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :  non-portable
--
-- Provides the 'MultipleFilterGroupResponse' type, to collect results of 'FilterGroup' type.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ResultWrappers.FilterGroup
where

import           Control.DeepSeq                       (NFData)
import           Data.Data                             (Data, Typeable)
import           GHC.Generics                          (Generic)
import           Web.Skroutz.Model.Base.FilterGroup
import           Web.Skroutz.Model.ResultWrappers.Meta
import           Web.Skroutz.TH

data MultipleFilterGroupResponse = MultipleFilterGroupResponse {
    _multipleFilterGroupResponseFilterGroups :: [FilterGroup]
  , _multipleFilterGroupResponseMeta         :: Meta
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''MultipleFilterGroupResponse "_multipleFilterGroupResponse"
