{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE TemplateHaskell #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types.ResultWrappers.Product
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'Product' type.
----------------------------------------------------------------------------
module Web.Skroutz.Types.ResultWrappers.Product
where

import           Data.Text              (Text)
import           GHC.Generics           (Generic)
import           Web.Skroutz.TH
import           Web.Skroutz.Types.ResultWrappers.Meta
import           Web.Skroutz.Types.Base.URI
import           Web.Skroutz.Types.Base.Product

data SingleProductResponse = SingleProductResponse {
    _singleProductResponseProduct :: Product
  } deriving (Generic, Show)

makeLensesAndJSON ''SingleProductResponse "_singleProductResponse"

data MultipleProductResponse = MultipleProductResponse {
    _multipleProductResponseProducts :: [Product]
  , _multipleProductResponseMeta     :: Meta
  } deriving (Generic, Show)

makeLensesAndJSON ''MultipleProductResponse "_multipleProductResponse"
