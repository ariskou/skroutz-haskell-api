{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Endoints.Types
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Skroutz API endpoints/methods for normal data retrieval.
----------------------------------------------------------------------------
module Web.Skroutz.Endpoints.Types
(
  module X
)
where

import           Web.Skroutz.Endpoints.Types.Category     as X
import           Web.Skroutz.Endpoints.Types.Common       as X
import           Web.Skroutz.Endpoints.Types.Manufacturer as X
import           Web.Skroutz.Endpoints.Types.Product      as X
import           Web.Skroutz.Endpoints.Types.Sku          as X
import           Web.Skroutz.Endpoints.Types.Shop         as X
