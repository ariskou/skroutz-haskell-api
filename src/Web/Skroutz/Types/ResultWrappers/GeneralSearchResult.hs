{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ResultWrappers.GeneralSearchResult
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'GeneralSearchResult' type, representing multiple types of search results.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ResultWrappers.GeneralSearchResult
where

import           Control.DeepSeq                       (NFData)
import           Data.Data                             (Data, Typeable)
import           GHC.Generics                          (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Base.Category
import           Web.Skroutz.Types.ResultWrappers.Meta

data MultipleGeneralSearchResultResponse = MultipleGeneralSearchResultResponse {
    _multipleGeneralSearchResultResponseCategories :: [Category]
  , _multipleGeneralSearchResultResponseMeta       :: Meta
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''MultipleGeneralSearchResultResponse "_multipleGeneralSearchResultResponse"
