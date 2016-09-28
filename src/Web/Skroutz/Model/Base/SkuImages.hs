{-# LANGUAGE DeriveAnyClass     #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE TemplateHaskell    #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.SkuImages
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'SkuImages' type, the structured images of a 'Sku'.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.SkuImages
where

import           Control.DeepSeq            (NFData)
import           Data.Data                  (Data, Typeable)
import           GHC.Generics               (Generic)
import           Web.Skroutz.Model.Base.URI
import           Web.Skroutz.TH

data SkuImages = SkuImages {
    _skuImagesMain         :: URI
  , _skuImagesAlternatives :: [URI]
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndJSON ''SkuImages "_skuImages"
