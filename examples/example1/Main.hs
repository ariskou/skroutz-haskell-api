{-# LANGUAGE OverloadedStrings #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Main
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :  non-portable
--
-- Provides an example of the usage of the Skroutz API endpoints/methods.
-- The code is somewhat more verbose than usual to aid the illustration of the
-- functionality.
----------------------------------------------------------------------------
module Main
where

import           Control.Lens               ((^..), (^?), _Just)
import           Control.Monad.Trans.Except (runExceptT)
import           Data.Either.Combinators    (mapBoth)
import           Data.Map                   as Map
import           Data.Text                  (Text, pack, unpack)
import           Network.HTTP.Client        (newManager)
import           Servant.API                (getHeaders, getResponse)
import qualified Web.Skroutz                as Skroutz

getApiIdentifier :: IO Text
getApiIdentifier = do
  putStrLn "Please give the API Identifier (\"client_id\"):"
  pack <$> getLine

getApiSecret :: IO Text
getApiSecret = do
  putStrLn "Please give the API Secret (\"client_secret\"):"
  pack <$> getLine

getAuthToken :: IO (Either String Text)
getAuthToken = do
  apiIdentifier <- getApiIdentifier
  putStrLn ""
  apiSecret <- getApiSecret
  putStrLn ""
  manager <- newManager Skroutz.defaultAuthManagerSettings

  result <- runExceptT $ Skroutz.getTokenWithDefaultParams apiIdentifier apiSecret manager
  return $ mapBoth show Skroutz._tokenAccessToken result

showResult :: Skroutz.WithHeaders Skroutz.MultipleCategoryResponse -> String
showResult multipleCategoriesWithHeaders =
  let multipleCategories = getResponse multipleCategoriesWithHeaders
      namesOfCategories = multipleCategories ^.. (Skroutz.multipleCategoryResponseCategories . traverse . Skroutz.categoryName)
      totalResultsCount = multipleCategories ^? (Skroutz.multipleCategoryResponseMeta . Skroutz.metaPagination . _Just . Skroutz.paginationTotalResults)
      headers = getHeaders multipleCategoriesWithHeaders
      rateLimitRemaining = "X-RateLimit-Remaining" `Map.lookup` (Map.fromList headers)
  in  "\nShowing the names of the first "
      ++ show (length namesOfCategories)
      ++ " of the total "
      ++ maybe "unknown" show totalResultsCount
      ++ " Categories:\n"
      ++ unlines (fmap unpack namesOfCategories)
      ++ "\n\nRemaining requests (due to rate limiting) in the next minute:\n"
      ++ maybe "unknown" show rateLimitRemaining

exampleApiCall :: Text -> IO ()
exampleApiCall authToken = do
  manager <- newManager Skroutz.defaultDataManagerSettings
  eitherResult <- runExceptT $ Skroutz.withStdParamsPagedDefaults Skroutz.getCategories authToken manager
  putStrLn $ either show showResult eitherResult

main :: IO ()
main = do
  eitherAuthToken <- getAuthToken
  case eitherAuthToken of
    Left msg        -> putStrLn $ "Could not get authorized: " ++ msg
    Right authToken -> exampleApiCall authToken
