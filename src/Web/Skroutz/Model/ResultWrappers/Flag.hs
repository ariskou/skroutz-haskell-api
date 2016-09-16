{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.ResultWrappers.Flag
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Flag' type, used to mark user provided content as requiring attention/moderation.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ResultWrappers.Flag
where

import           Control.DeepSeq             (NFData)
import           Data.Data                   (Data, Typeable)
import           GHC.Generics                (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Model.Base.Flag

data MultipleFlagResponse = MultipleFlagResponse {
    _multipleFlagResponseFlags :: [Flag]
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''MultipleFlagResponse "_multipleFlagResponse"
