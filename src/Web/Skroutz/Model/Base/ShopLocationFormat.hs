{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DeriveDataTypeable    #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.ShopLocationFormat
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability : non-portable
--
-- Provides the 'ShopLocationFormat' type, a type representing the possible types of formats for shop location addresses.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.ShopLocationFormat
where

import           Control.DeepSeq (NFData)
import           Data.Data       (Data, Typeable)
import           GHC.Generics    (Generic)
import           Web.Skroutz.TH

data ShopLocationFormat = ShopLocationFormatStructured | ShopLocationFormatUnstructured
  deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSONSumType ''ShopLocationFormat "" "ShopLocationFormat"
