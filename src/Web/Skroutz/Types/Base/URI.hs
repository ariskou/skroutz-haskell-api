{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DeriveDataTypeable    #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.Base.URI
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'URI' type, a newtype wrapper around Network.URI.URI.
----------------------------------------------------------------------------
module Web.Skroutz.Types.Base.URI
where

import           Control.DeepSeq (NFData)
import           Control.Monad
import qualified Data.Aeson      as Aeson
import           Data.Coerce     (coerce)
import           Data.Data       (Data, Typeable)
import           Data.Text       (pack, unpack)
import           GHC.Generics    (Generic)
import qualified Network.URI     (URI, parseURI)

newtype URI = URI {
    unUri :: Network.URI.URI
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

instance Aeson.FromJSON URI where
  parseJSON (Aeson.String uri) =
    case Network.URI.parseURI (unpack uri) of
      Just x -> return $ coerce x
      Nothing -> mzero
  parseJSON _            = mzero

instance Aeson.ToJSON URI where
  toJSON = Aeson.String . pack . show
