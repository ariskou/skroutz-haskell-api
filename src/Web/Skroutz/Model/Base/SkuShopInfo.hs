{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DeriveDataTypeable    #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TemplateHaskell       #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.SkuShopInfo
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides the 'SkuShopInfo' type, which contains the basic information of a 'Shop' related to an 'SKU'.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.SkuShopInfo
where

import           Control.DeepSeq      (NFData)
import qualified Data.Aeson           as Aeson
import           Data.Aeson.Types     (typeMismatch)
import           Data.Data            (Data, Typeable)
import           Data.Foldable        (toList)
import           Data.List            (intersperse)
import           Data.Text            (Text, concat, pack)
import           Data.Text.Read       (decimal)
import           GHC.Generics         (Generic)
import           Text.Regex.TDFA      (makeRegex, matchOnceText)
import           Text.Regex.TDFA.Text (Regex)
import           Web.Skroutz.TH

data SkuShopInfo = SkuShopInfo {
    _skuShopInfoId       :: Int
  , _skuShopInfoName     :: Text
  , _skuShopInfoUsername :: Text -- Just a guess of what this is, not documented
  } deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndPrisms ''SkuShopInfo

skuShopInfoRegex :: Regex
skuShopInfoRegex = makeRegex ("^([0-9]+)\\|([^|]*)\\|(.*)$" :: Text)

instance Aeson.FromJSON SkuShopInfo where
  parseJSON value@(Aeson.String info) =
    case matchOnceText skuShopInfoRegex info of
      Just (_, matchArray, _) ->
        let [_, shopid, shopname, shopusername] = toList $ fmap fst matchArray
        in  case decimal shopid of
          Left _ -> typeMismatch "SkuShopInfo" value
          Right (shopidint, _) -> return SkuShopInfo {
              _skuShopInfoId = shopidint
            , _skuShopInfoName = shopname
            , _skuShopInfoUsername = shopusername
          }
      Nothing -> typeMismatch "SkuShopInfo" value
  parseJSON invalid            = typeMismatch "SkuShopInfo" invalid

instance Aeson.ToJSON SkuShopInfo where
  toJSON SkuShopInfo {
      _skuShopInfoId = shopid
    , _skuShopInfoName = shopname
    , _skuShopInfoUsername = shopusername
    } = Aeson.String $ Data.Text.concat $ intersperse "|" [pack $ show shopid, shopname, shopusername]
