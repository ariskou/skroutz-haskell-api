{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.ResultWrappers.Pagination
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Meta' type, used for metadata in results, such as 'Pagination'.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ResultWrappers.Meta
where

import           Control.DeepSeq                                   (NFData)
import           Data.Data                                         (Data, Typeable)
import           Data.Text                                         (Text)
import           GHC.Generics                                      (Generic)
import           Web.Skroutz.Model.ResultWrappers.Alternative
import           Web.Skroutz.Model.ResultWrappers.AppliedFilters
import           Web.Skroutz.Model.ResultWrappers.AvailableFilters
import           Web.Skroutz.Model.ResultWrappers.OrderBy
import           Web.Skroutz.Model.ResultWrappers.Pagination
import           Web.Skroutz.Model.ResultWrappers.StrongMatches
import           Web.Skroutz.TH

data Meta = Meta {
    _metaPagination       :: Maybe Pagination
  , _metaOrderedBy        :: Maybe OrderBy
  , _metaAppliedFilters   :: Maybe AppliedFilters
  , _metaAvailableFilters :: Maybe AvailableFilters
  , _metaQ                :: Maybe Text
  , _metaAlternatives     :: Maybe [Alternative]
  , _metaStrongMatches    :: Maybe StrongMatches
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''Meta "_meta"
