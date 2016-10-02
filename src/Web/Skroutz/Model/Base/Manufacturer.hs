{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.Manufacturer
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :  non-portable
--
-- Provides the 'Manufacturer' type.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.Manufacturer
where

import           Control.DeepSeq            (NFData)
import           Data.Data                  (Data, Typeable)
import           Data.Text                  (Text)
import           GHC.Generics               (Generic)
import           Web.Skroutz.Model.Base.URI
import           Web.Skroutz.TH

data Manufacturer = Manufacturer {
    _manufacturerId       :: Int
  , _manufacturerName     :: Text
  , _manufacturerImageUrl :: Maybe URI
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''Manufacturer "_manufacturer"
