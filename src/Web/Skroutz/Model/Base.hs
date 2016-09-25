----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the Skroutz API 'Web.Skroutz.Model.Base' for JSON marshalling.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base
  (
    module X
  )
where

import           Web.Skroutz.Model.Base.Autocomplete        as X
import           Web.Skroutz.Model.Base.Category            as X
import           Web.Skroutz.Model.Base.CategoryPath        as X
import           Web.Skroutz.Model.Base.FilterGroup         as X
import           Web.Skroutz.Model.Base.FilterGroupType     as X
import           Web.Skroutz.Model.Base.Flag                as X
import           Web.Skroutz.Model.Base.Gender              as X
import           Web.Skroutz.Model.Base.ISO8601Time         as X
import           Web.Skroutz.Model.Base.LayoutMode          as X
import           Web.Skroutz.Model.Base.Manufacturer        as X
import           Web.Skroutz.Model.Base.Product             as X
import           Web.Skroutz.Model.Base.Shop                as X
import           Web.Skroutz.Model.Base.ShopLocation        as X
import           Web.Skroutz.Model.Base.ShopLocationAddress as X
import           Web.Skroutz.Model.Base.ShopPaymentMethods  as X
import           Web.Skroutz.Model.Base.ShopReview          as X
import           Web.Skroutz.Model.Base.ShopShipping        as X
import           Web.Skroutz.Model.Base.Sku                 as X
import           Web.Skroutz.Model.Base.SkuImages           as X
import           Web.Skroutz.Model.Base.SkuPrice            as X
import           Web.Skroutz.Model.Base.SkuReview           as X
import           Web.Skroutz.Model.Base.SkuSpecification    as X
import           Web.Skroutz.Model.Base.Token               as X
import           Web.Skroutz.Model.Base.URI                 as X
import           Web.Skroutz.Model.Base.User                as X
