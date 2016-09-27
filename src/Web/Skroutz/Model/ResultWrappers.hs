----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.ResultWrappers
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Skroutz API 'Web.Skroutz.Model.ResultWrappers' for JSON marshalling.
----------------------------------------------------------------------------
module Web.Skroutz.Model.ResultWrappers
  (
    module X
  )
where

import           Web.Skroutz.Model.ResultWrappers.Alternative         as X
import           Web.Skroutz.Model.ResultWrappers.AppliedFilters      as X
import           Web.Skroutz.Model.ResultWrappers.Autocomplete        as X
import           Web.Skroutz.Model.ResultWrappers.AvailableFilters    as X
import           Web.Skroutz.Model.ResultWrappers.Category            as X
import           Web.Skroutz.Model.ResultWrappers.FilterGroup         as X
import           Web.Skroutz.Model.ResultWrappers.Flag                as X
import           Web.Skroutz.Model.ResultWrappers.GeneralSearchResult as X
import           Web.Skroutz.Model.ResultWrappers.Manufacturer        as X
import           Web.Skroutz.Model.ResultWrappers.Meta                as X
import           Web.Skroutz.Model.ResultWrappers.OrderBy             as X
import           Web.Skroutz.Model.ResultWrappers.Pagination          as X
import           Web.Skroutz.Model.ResultWrappers.Product             as X
import           Web.Skroutz.Model.ResultWrappers.Shop                as X
import           Web.Skroutz.Model.ResultWrappers.ShopLocation        as X
import           Web.Skroutz.Model.ResultWrappers.ShopReview          as X
import           Web.Skroutz.Model.ResultWrappers.Sku                 as X
import           Web.Skroutz.Model.ResultWrappers.SkuPrice            as X
import           Web.Skroutz.Model.ResultWrappers.SkuReview           as X
import           Web.Skroutz.Model.ResultWrappers.SkuSpecification    as X
import           Web.Skroutz.Model.ResultWrappers.StrongMatches       as X
