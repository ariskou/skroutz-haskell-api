{-# LANGUAGE OverloadedStrings #-}
----------------------------------------------------------------------------
-- |
-- Module      :  Web.Skroutz.TestingEnvironment
-- Copyright   :  (c) 2016 Remous-Aris Koutsiamanis
-- License     :  Apache License 2.0
-- Maintainer  :  Remous-Aris Koutsiamanis <ariskou@gmail.com>
-- Stability   :  alpha
-- Portability :  non-portable
--
-- Provides helper functions for the tests.
----------------------------------------------------------------------------
module Web.Skroutz.TestingEnvironment
where

import           Control.Monad.Trans.Except (runExceptT)
import qualified Data.ByteString            as B
import           Data.Either.Combinators    (fromRight')
import           Data.Text                  (Text, pack)
import           Data.Text.Encoding         (encodeUtf8)
import           Network.HTTP.Client        (newManager)
import           System.Directory           (getCurrentDirectory)
import           System.Environment         (getEnv)
import           System.FilePath            ((</>))
import qualified Web.Skroutz                as Skroutz

apiIdentifierEnvKey :: String
apiIdentifierEnvKey = "API_IDENTIFIER"

apiSecretEnvKey :: String
apiSecretEnvKey = "API_SECRET"

getApiIdentifier :: IO Text
getApiIdentifier = pack <$> getEnv apiIdentifierEnvKey

getApiSecret :: IO Text
getApiSecret = pack <$> getEnv apiSecretEnvKey

getAuthToken :: IO B.ByteString
getAuthToken = do
  apiIdentifier <- getApiIdentifier
  apiSecret <- getApiSecret
  manager <- newManager Skroutz.defaultAuthManagerSettings

  result <- runExceptT $ Skroutz.getTokenWithDefaultParams apiIdentifier apiSecret manager
  return $ encodeUtf8 $ Skroutz._tokenAccessToken $ fromRight' result

getFixtureDir :: IO FilePath
getFixtureDir = do
  dir <- getCurrentDirectory
  return $ dir </> "test" </> "fixtures"
