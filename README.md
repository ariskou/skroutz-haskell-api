# skroutz-haskell-api
Haskell bindings for the Skroutz.gr API

## Version support
Tested with GHC 7.10.3 (Stackage LTS 6.20) and 8.0.1 (Stackage LTS 7.2).
Built using servant and servant-client to define the API endpoints and aeson for the API data model serialisation to/from JSON.

## Usage
Import the top-level module Web.Skroutz to get all the definitions for both the API data model as well as the definitions for the API endpoints.
Import Web.Skroutz.Model for the API data model only and Web.Skroutz.Endpoints for the API endpoints only.

In order to access the web service an API identifier and an API secret are required, which can be requested from here. These should be provided to the 'Web.Skroutz.Endpoints.Auth.getToken' endpoint in order to get a temporary API token. This token must be provided to all subsequent API calls to authenticate them.
