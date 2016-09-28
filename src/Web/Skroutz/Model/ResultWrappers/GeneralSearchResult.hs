{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.ResultWrappers.GeneralSearchResult
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'GeneralSearchResult' type, representing multiple types of search results.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ResultWrappers.GeneralSearchResult
where

import           Control.DeepSeq                       (NFData)
import           Data.Data                             (Data, Typeable)
import           GHC.Generics                          (Generic)
import           Web.Skroutz.Model.Base.Category
import           Web.Skroutz.Model.ResultWrappers.Meta
import           Web.Skroutz.TH

data MultipleGeneralSearchResultResponse = MultipleGeneralSearchResultResponse {
    _multipleGeneralSearchResultResponseCategories :: [Category]
  , _multipleGeneralSearchResultResponseMeta       :: Meta
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''MultipleGeneralSearchResultResponse "_multipleGeneralSearchResultResponse"
