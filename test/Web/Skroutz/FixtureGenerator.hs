{-# LANGUAGE ExplicitForAll      #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.FixtureGenerator
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :
--
-- Provides a function which generates JSON fixtures for tests.
----------------------------------------------------------------------------
module Web.Skroutz.FixtureGenerator
(
  generate
)
where

import           Control.Monad.Trans.Except (runExceptT)
import qualified Data.ByteString            as B
import qualified Data.ByteString.Lazy       as BL
import           Data.Either.Combinators    (fromRight')
import           Data.Foldable              (traverse_)
import           Data.Text                  (pack)
import           Data.Text.Encoding         (encodeUtf8)
import           Network.HTTP.Client
import           Network.HTTP.Types.Status  (statusCode)
import           System.Directory           (getCurrentDirectory)
import           System.Environment         (getEnv)
import           System.FilePath            ((</>))
import qualified Web.Skroutz                as Skroutz

apiIdentifierEnvKey :: String
apiIdentifierEnvKey = "API_IDENTIFIER"

apiSecretEnvKey :: String
apiSecretEnvKey = "API_SECRET"

apiEntrypoint :: String
apiEntrypoint = "http://api.skroutz.gr"

apiEntries :: [(String, String)]
apiEntries = [
    ("categories_index", "/categories")
  , ("categories_root", "/categories/root")
  , ("categories_show", "/categories/1442")
  , ("children_api_category", "/categories/1434/children") -- is 73 in the docs, but that category does not exist
  , ("category_manufacturers", "/categories/25/manufacturers")
  , ("category_skus", "/categories/40/skus")
  , ("category_parent", "/categories/1442/parent")
  , ("shops_show", "/shops/452")
  , ("shop_locations_index", "/shops/452/locations")
  , ("shop_locations_index_embed_address", "/shops/452/locations?embed=address")
  , ("shop_locations_show", "/shops/452/locations/2500")
  , ("shop_locations_show_embed_address", "/shops/452/locations/2500?embed=address")
  , ("manufacturers_show", "/manufacturers/12907")
  , ("manufacturers_index", "/manufacturers")
  , ("manufacturer_categories", "/manufacturers/356/categories")
  , ("manufacturer_skus", "/manufacturers/356/skus")
  , ("autocomplete", "/autocomplete?q=iph")
  , ("search_invalid", "/search?q=a")
  , ("search_category_match", "/search?q=Tablets")
  , ("search_manufacturer_match", "/search?q=apple")
  , ("search_latin_mapping", "/search?q=ιπηονε")
  , ("search_spelling", "/search?q=ipone")
  , ("search_drop", "/search?q=wrong+iphone")
  , ("search_no_results", "/search?q=asdf")
  , ("search_category_facade", "/search?q=iphone")
  , ("search_sku_match", "/search?q=nikon+1+j2")
  , ("search_skus_match", "/search?q=samsung+galaxy+s5+16GB")
  , ("skus_show", "/skus/3690169")
  , ("skus_reviews", "/skus/3690169/reviews")
  , ("skus_products", "/skus/3783654/products")
  , ("skus_similar", "/skus/3034682/similar")
  , ("skus_price_history", "/skus/3034682/price_history")
  , ("products_show", "/products/12176638")
  , ("products_search", "/shops/452/products/search?shop_uid=95F")
  , ("filter_groups_index", "/categories/40/filter_groups")
  , ("category_skus_search", "/categories/40/skus?q=iphone")
  , ("category_skus_manufacturers", "/categories/40/skus?manufacturer_ids%5B%5D=28&manufacturer_ids%5B%5D=2")
  , ("category_skus_filters", "/categories/40/skus?filter_ids%5B%5D=355559&filter_ids%5B%5D=6282")
  , ("category_skus_with_available_filters", "/categories/279/skus?include_meta=available_filters")
  , ("category_skus_with_applied_filters", "/categories/40/skus?include_meta=applied_filters&filter_ids%5B%5D=6282&manufacturer_ids%5B%5D=28")
  , ("sku_reviews", "/skus/355766/reviews")
  , ("sku_specifications", "/skus/2588170/specifications")
  , ("sku_specifications_include_group", "/skus/2588170/specifications?include=group")
  , ("shop_reviews", "/shops/452/reviews") -- is 3 in the docs, but that shop has no reviews
  , ("shop_search", "/shops/search?q=spartoo")
  , ("flags_index", "/flags")
  ]

getAuthToken :: IO B.ByteString
getAuthToken = do
  apiIdentifier <- getEnv apiIdentifierEnvKey
  apiSecret <- getEnv apiSecretEnvKey
  manager <- newManager Skroutz.defaultAuthManagerSettings

  result <- runExceptT $ Skroutz.getToken
    (Just $ pack apiIdentifier)
    (Just $ pack apiSecret)
    (Just Skroutz.defaultAuthPublicGrantType)
    (Just Skroutz.defaultAuthPublicRedirectUri)
    (Just Skroutz.defaultAuthPublicScope)
    manager
    Skroutz.defaultAuthBaseUrl

  return $ encodeUtf8 $ Skroutz._tokenAccessToken $ fromRight' result

getFixtureDir :: IO FilePath
getFixtureDir = do
  dir <- getCurrentDirectory
  return $ dir </> "test" </> "fixtures" </> "generated"

saveFixture :: B.ByteString -> String -> String -> IO ()
saveFixture authToken fixtureName fixtureApiPath = do
  manager <- newManager Skroutz.defaultDataManagerSettings
  initialRequest <- parseRequest (apiEntrypoint ++ fixtureApiPath)
  let request = initialRequest { method = "GET", requestHeaders = [("accept", "application/vnd.skroutz+json; version=3"), ("authorization", "Bearer " `B.append` authToken)]}

  response <- httpLbs request manager
  putStrLn $ fixtureName ++ ": The status code was: " ++ show (statusCode $ responseStatus response)
  fixtureDir <- getFixtureDir
  BL.writeFile (fixtureDir </> fixtureName ++ ".json") (responseBody response)

generate :: IO ()
generate = do
  authToken <- getAuthToken
  traverse_ (uncurry $ saveFixture authToken) apiEntries
