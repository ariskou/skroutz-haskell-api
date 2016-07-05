{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.Pagination
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Meta' type, used for metadata in results, such as 'Pagination'.
----------------------------------------------------------------------------
module Web.Skroutz.Types.Meta
where

import           Data.Text                        (Text)
import           GHC.Generics                     (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.AppliedFilters
import           Web.Skroutz.Types.Pagination

data Meta = Meta {
    _metaPagination     :: Pagination
  , _metaOrderedBy      :: Maybe Text
  , _metaAppliedFilters :: Maybe AppliedFilters
  } deriving (Generic, Show)

makeLensesAndJSON ''Meta "_meta"
