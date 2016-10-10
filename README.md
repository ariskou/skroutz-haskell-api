# skroutz-haskell-api

![Version v0.1.0.0](https://img.shields.io/badge/version-v0.1.0.0-brightgreen.svg)
![License Apache-2.0](https://img.shields.io/badge/license-Apache_2.0-blue.svg)
[![Build Status](https://travis-ci.org/ariskou/skroutz-haskell-api.svg?branch=travisci-integration)](https://travis-ci.org/ariskou/skroutz-haskell-api)

Haskell bindings for the [Skroutz.gr](https://www.skroutz.gr) product search and comparison service [API v3](http://developer.skroutz.gr/api/v3).

## Version support
Tested with GHC 7.10.3 (via [Stackage LTS 6.20](https://www.stackage.org/lts-6.20)) and 8.0.1 (via [Stackage LTS 7.2](https://www.stackage.org/lts-7.2)).
The library is based on [servant](http://haskell-servant.readthedocs.io/en/stable) to define the API endpoints and [aeson](https://github.com/bos/aeson) for the API data model serialisation to/from JSON.

## Usage
Import the top-level module `Web.Skroutz` to get all the definitions for both the API data model as well as the definitions for the API endpoints.
Import `Web.Skroutz.Model` for the API data model only and `Web.Skroutz.Endpoints` for the API endpoints only.

In order to access the web service an API identifier ("client_id") and an API secret ("client_secret") are required, which can be requested using [this request form](http://skroutz.it/API_access).
These should be provided to the `Web.Skroutz.Endpoints.Auth.getToken` endpoint in order to get a temporary API token, implementing [OAuth 2.0 authorisation](http://developer.skroutz.gr/authorization). This token must be provided to all subsequent API calls (in `Web.Skroutz.Endpoints.Model`) to authenticate them.

## Notes
At this point, some of the API endpoints (mainly those having to do with accessing user data) are not supported due to lack of access permissions for testing them.
