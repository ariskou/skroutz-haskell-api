{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.Base.GeneralSearchResult
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'GeneralSearchResult' type, representing multiple types of search results.
----------------------------------------------------------------------------
module Web.Skroutz.Types.Base.GeneralSearchResult
where

import           GHC.Generics               (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Base.Category
import           Web.Skroutz.Types.Base.Meta

data MultipleGeneralSearchResultResponse = MultipleGeneralSearchResultResponse {
    _multipleGeneralSearchResultResponseCategories :: [Category]
  , _multipleGeneralSearchResultResponseMeta       :: Meta
  } deriving (Generic, Show)

makeLensesAndJSON ''MultipleGeneralSearchResultResponse "_multipleGeneralSearchResultResponse"
