{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DeriveDataTypeable    #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell       #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.Gender
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Gender' type, a type representing the supported possible genders for users.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.Gender
where

import           Control.DeepSeq (NFData)
import           Data.Data       (Data, Typeable)
import           GHC.Generics    (Generic)
import           Web.Skroutz.TH

data Gender = GenderMale | GenderFemale
  deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSONSumType ''Gender "" "Gender"
