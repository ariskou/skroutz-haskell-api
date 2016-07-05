----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Types
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Skroutz API 'Types' for JSON marshalling.
----------------------------------------------------------------------------
module Web.Skroutz.Types
  (
    module X
  )
where

import           Web.Skroutz.Types.Base.AppliedFilters      as X
import           Web.Skroutz.Types.Base.AvailableFilters    as X
import           Web.Skroutz.Types.Base.Category            as X
import           Web.Skroutz.Types.Base.FilterGroup         as X
import           Web.Skroutz.Types.Base.GeneralSearchResult as X
import           Web.Skroutz.Types.Base.Manufacturer        as X
import           Web.Skroutz.Types.Base.Meta                as X
import           Web.Skroutz.Types.Base.Pagination          as X
import           Web.Skroutz.Types.Base.Product             as X
import           Web.Skroutz.Types.Base.Shop                as X
import           Web.Skroutz.Types.Base.ShopLocation        as X
import           Web.Skroutz.Types.Base.ShopLocationAddress as X
import           Web.Skroutz.Types.Base.ShopPaymentMethods  as X
import           Web.Skroutz.Types.Base.ShopReview          as X
import           Web.Skroutz.Types.Base.ShopShipping        as X
import           Web.Skroutz.Types.Base.Sku                 as X
import           Web.Skroutz.Types.Base.SkuImages           as X
import           Web.Skroutz.Types.Base.SkuPrice            as X
import           Web.Skroutz.Types.Base.SkuReview           as X
import           Web.Skroutz.Types.Base.SkuSpecification    as X
import           Web.Skroutz.Types.Base.StrongMatches       as X
import           Web.Skroutz.Types.Base.Token               as X
import           Web.Skroutz.Types.Base.URI                 as X
