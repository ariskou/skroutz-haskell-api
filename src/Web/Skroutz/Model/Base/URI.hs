{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DeriveDataTypeable    #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.URI
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability : non-portable
--
-- Provides the 'URI' type, a newtype wrapper around 'Network.URI.URI' in "Network.URI".
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.URI
where

import           Control.DeepSeq  (NFData)
import qualified Data.Aeson       as Aeson
import           Data.Aeson.Types (typeMismatch)
import           Data.Data        (Data, Typeable)
import           Data.Text        (pack, unpack)
import           GHC.Generics     (Generic)
import qualified Network.URI      (URI, parseURI)
import           Web.Skroutz.TH

newtype URI = URI Network.URI.URI
  deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndPrisms ''URI

instance Aeson.FromJSON URI where
  parseJSON value@(Aeson.String uri) =
    case Network.URI.parseURI (unpack uri) of
      Just x  -> return $ URI x
      Nothing -> typeMismatch "URI" value
  parseJSON invalid = typeMismatch "URI" invalid

instance Aeson.ToJSON URI where
  toJSON = Aeson.String . pack . show
