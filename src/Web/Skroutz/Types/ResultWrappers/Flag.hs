{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ResultWrappers.Flag
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Flag' type, used to mark user provided content as requiring attention/moderation.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ResultWrappers.Flag
where

import           GHC.Generics                (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.Base.Flag

data MultipleFlagResponse = MultipleFlagResponse {
    _multipleFlagResponseFlags :: [Flag]
  } deriving (Generic, Show)

makeLensesAndJSON ''MultipleFlagResponse "_multipleFlagResponse"
