#!/usr/bin/python

API_ENTRIES = [
    ("categories_index", "/categories")
    , ("categories_root", "/categories/root")
    , ("categories_show", "/categories/1442")
    , ("children_api_category", "/categories/73/children")
    , ("category_manufacturers", "/categories/25/manufacturers")
    , ("category_skus", "/categories/40/skus")
    , ("category_parent", "/categories/1442/parent")
    , ("category_favorites", "/categories/40/favorites")
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
    , ("sku_favorite", "/skus/345333/favorite")
    , ("products_show", "/products/12176638")
    , ("products_search", "/shops/452/products/search?shop_uid=95F")
    , ("favorites_index", "/favorites")
    , ("favorites_show", "/favorites/825561")
    , ("favorite_lists_index", "/favorite_lists")
    , ("filter_groups_index", "/categories/40/filter_groups")
    , ("category_skus_search", "/categories/40/skus?q=iphone")
    , ("category_skus_manufacturers", "/categories/40/skus?manufacturer_ids[]=28&manufacturer_ids[]=2")
    , ("category_skus_filters", "/categories/40/skus?filter_ids[]=355559&filter_ids[]=6282")
    , ("category_skus_with_available_filters", "/categories/279/skus?include_meta=available_filters")
    , ("category_skus_with_applied_filters", "/categories/40/skus?include_meta=applied_filters&filter_ids[]=6282&manufacturer_ids[]=28")
    , ("notifications_index", "/notifications")
    , ("notifications_show", "/notifications/3642082")
    , ("sku_reviews", "/skus/355766/reviews")
    , ("sku_specifications", "/skus/2588170/specifications")
    , ("sku_specifications_include_group", "/skus/2588170/specifications?include=group")
    , ("shop_reviews", "/shops/3/reviews")
    , ("shop_search", "/shops/search?q=spartoo")
    , ("flags_index", "/flags")
    , ("user", "/user")
    ]

if __name__=="__main__":
    pass
