{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.SkuImages
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'SkuImages' type, the structured images of a 'Sku'.
----------------------------------------------------------------------------
module Web.Skroutz.Types.SkuImages
where

import           GHC.Generics          (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.URI

data SkuImages = SkuImages {
    _skuImagesMain         :: URI
  , _skuImagesAlternatives :: [URI]
  } deriving (Generic, Show)

makeLensesAndJSON ''SkuImages "_skuImages"
