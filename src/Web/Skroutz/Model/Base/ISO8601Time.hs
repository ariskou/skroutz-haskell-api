{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DeriveDataTypeable    #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NamedFieldPuns        #-}
{-# LANGUAGE TemplateHaskell       #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.ISO8601Time
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :  non-portable
--
-- Provides the 'ISO8601Time' type, a newtype wrapper around
-- 'Data.Time.ZonedTime' in ISO 8601 format.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.ISO8601Time
where

import           Control.DeepSeq (NFData)
import qualified Data.Aeson      as Aeson
import           Data.Data       (Data, Typeable)
import           Data.Time       (ZonedTime, zonedTimeToUTC)
import           GHC.Generics    (Generic)
import           Web.Skroutz.TH

newtype ISO8601Time = ISO8601Time ZonedTime
  deriving (Typeable, Data, Generic, Show, NFData)

instance Eq ISO8601Time where
  ISO8601Time t1 == ISO8601Time t2 = zonedTimeToUTC t1 == zonedTimeToUTC t2

instance Ord ISO8601Time where
  compare (ISO8601Time t1) (ISO8601Time t2) = compare (zonedTimeToUTC t1) (zonedTimeToUTC t2)

makeLensesAndPrisms ''ISO8601Time

instance Aeson.FromJSON ISO8601Time where
  parseJSON value = fmap ISO8601Time (Aeson.parseJSON value)

instance Aeson.ToJSON ISO8601Time where
  toJSON (ISO8601Time zonedTime) = Aeson.toJSON zonedTime
