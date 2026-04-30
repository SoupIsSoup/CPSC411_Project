//**********************************************************************************************************************
// Program name: "YelpResponse.swift".
// This file defines the Yelp API response models used to decode restaurant search JSON.
// Copyright (C) 2026 Jake Miso
//
// This program is free software: you can redistribute it and/or modify it under the terms of the GNU GPL v3.
// This program is distributed WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY.
// See <https://www.gnu.org/licenses/> for more details.
//**********************************************************************************************************************

//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0==================
// Author information
//   Author name: Jake Miso
//   Author email: jamiso@csu.fullerton.edu
//
// Program information
//   Program name: FoodFinder
//   Programming language: Swift
//   Date development began: 2026-Apr-28
//   Status: In development
//
// Purpose
//   Define data structures used to decode JSON responses returned from the Yelp API.
//
//===== Begin code area ===============================================================================================

import Foundation

//======================================================================================================================
// MARK: - YelpResponse Structure
//======================================================================================================================
// This structure represents the top-level JSON object returned by Yelp when performing a search request.
// The key "businesses" contains an array of restaurant objects.
//======================================================================================================================

nonisolated struct YelpResponse: Codable {

    // Array of Restaurant objects returned by Yelp API
    let businesses: [Restaurant]
}

//======================================================================================================================
// MARK: - YelpLocation Structure
//======================================================================================================================
// This structure represents the nested "location" object inside each restaurant JSON object.
// Yelp returns address components separately, so we combine them later when displaying.
//======================================================================================================================

nonisolated struct YelpLocation: Codable {

    // Street address line (e.g., "123 Main St")
    let address1: String?

    // City name (e.g., "Fullerton")
    let city: String?

    // State abbreviation (e.g., "CA")
    let state: String?

    // ZIP code (e.g., "92831")
    let zip_code: String?
}


