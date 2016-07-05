{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ResultWrappers.Pagination
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Pagination' type.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ResultWrappers.Pagination
where

import           GHC.Generics   (Generic)
import           Web.Skroutz.TH

data Pagination = Pagination {
    _paginationTotalResults :: Int
  , _paginationTotalPages   :: Int
  , _paginationPage         :: Int
  , _paginationPer          :: Int
  } deriving (Generic, Show)

makeLensesAndJSON ''Pagination "_pagination"
