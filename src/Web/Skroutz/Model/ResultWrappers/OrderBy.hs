{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DeriveDataTypeable    #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.ResultWrappers.OrderBy
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'OrderBy' type, a type represinting the possible types of ordering in rearches.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ResultWrappers.OrderBy
where

import           Control.DeepSeq (NFData)
import           Control.Monad
import qualified Data.Aeson      as Aeson
import           Data.Coerce     (coerce)
import           Data.Data       (Data, Typeable)
import           Data.Text       (pack, unpack)
import           GHC.Generics    (Generic)
import qualified Network.URI     (URI, parseURI)
import           Web.Skroutz.TH

data OrderBy = OrderByPopularity | OrderByPrice | OrderByPriceVAT | OrderByRating | OrderByName
  deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSONSumType ''OrderBy "" "OrderBy"
