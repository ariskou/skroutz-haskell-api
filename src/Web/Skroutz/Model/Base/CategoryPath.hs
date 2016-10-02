{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DeriveDataTypeable    #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TemplateHaskell       #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.Model.Base.CategoryPath
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability : non-portable
--
-- Provides the 'CategoryPath' type, a newtype wrapper around [Int] representing
-- the path of 'Web.Skroutz.Model.Base.Category.Category' IDs leading to a
-- 'Web.Skroutz.Model.Base.Category.Category'.
----------------------------------------------------------------------------
module Web.Skroutz.Model.Base.CategoryPath
where

import           Control.DeepSeq      (NFData)
import qualified Data.Aeson           as Aeson
import           Data.Aeson.Types     (typeMismatch)
import           Data.ByteString.Lazy (fromStrict)
import           Data.Data            (Data, Typeable)
import           Data.List            (intersperse)
import           Data.Text            (concat, pack)
import           Data.Text.Encoding   (encodeUtf8)
import           GHC.Generics         (Generic)
import           Web.Skroutz.TH

newtype CategoryPath = CategoryPath [Int]
  deriving (Eq, Ord, Typeable, Data, Generic, Show, NFData)

makeLensesAndPrisms ''CategoryPath

instance Aeson.FromJSON CategoryPath where
  parseJSON value@(Aeson.String pathText) = do
    let withBrackets = fromStrict $ encodeUtf8 $ Data.Text.concat ["[", pathText, "]"]
    case (Aeson.decode withBrackets :: Maybe [Int]) of
      Just xs -> return $ CategoryPath xs
      Nothing -> typeMismatch "CategoryPath" value
  parseJSON invalid            = typeMismatch "CategoryPath" invalid

instance Aeson.ToJSON CategoryPath where
  toJSON (CategoryPath xs) = Aeson.String $ Data.Text.concat $ intersperse "," $ map (pack . show) xs
