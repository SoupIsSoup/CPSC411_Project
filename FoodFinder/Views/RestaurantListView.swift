//****************************************************************************************************************************
//Program name: "RestaurantListView.swift".  This file displays restaurant search results in a scrollable list.  Each row    *
//shows basic restaurant information returned from the Yelp API and allows navigation to a detail screen.                   *
//Copyright (C) 2026  Jake Miso                                                                                              *
//****************************************************************************************************************************




//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2**
//Author information
//  Author name: Jake Miso
//  Author email: jamiso@csu.fullerton.edu
//
//Program information
//  Program name: FoodFinder
//  Programming language: Swift
//  Date development of program began 2026-Apr-28
//  Date development of program completed TBD
//
//Purpose
//  Display an array of Restaurant objects in a SwiftUI List and allow navigation to a detailed view for each restaurant.
//
//Project information
//  Files: FoodFinderApp.swift, ContentView.swift, RestaurantListView.swift, RestaurantDetailView.swift,
//         FavoritesView.swift, Restaurant.swift, YelpResponse.swift, YelpService.swift, FavoritesManager.swift,
//         Secrets.swift, Secrets.example.swift
//  Status: In development.
//
//===== Begin code area ====================================================================================================================================================

import SwiftUI                                                   //Import SwiftUI for List, NavigationLink, VStack, and Text

//==========================================================================================================================================================================
//===== RestaurantListView structure =======================================================================================================================================
//==========================================================================================================================================================================

struct RestaurantListView: View {                                //Define RestaurantListView structure

    //======================================================================================================================================================================
    //===== Stored properties ==============================================================================================================================================
    //======================================================================================================================================================================

    let restaurants: [Restaurant]                                //Store restaurant array passed from ContentView

    //======================================================================================================================================================================
    //===== Body property ==================================================================================================================================================
    //======================================================================================================================================================================

    var body: some View {                                        //Define view layout

        List(restaurants) { restaurant in                        //Create one list row for each restaurant

            NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) { //Navigate using restaurant only

                VStack(alignment: .leading, spacing: 6) {        //Stack restaurant row text vertically

                    Text(restaurant.name)                        //Display restaurant name
                        .font(.headline)                         //Use headline font

                    Text("Rating: \(restaurant.rating ?? 0.0)")  //Display rating or fallback value
                        .font(.subheadline)                      //Use subheadline font

                    Text(restaurant.price ?? "No price listed")  //Display price or fallback text
                        .font(.subheadline)                      //Use subheadline font
                        .foregroundColor(.gray)                  //Make price gray

                    Text(formatAddress(for: restaurant))         //Display formatted restaurant address
                        .font(.caption)                          //Use caption font
                        .foregroundColor(.secondary)             //Use secondary color
                }
                .padding(.vertical, 6)                           //Add vertical row padding
            }
        }
    }

    //======================================================================================================================================================================
    //===== Format address helper function =================================================================================================================================
    //======================================================================================================================================================================
    //  Builds a readable address string from the optional YelpLocation object.
    //======================================================================================================================================================================

    private func formatAddress(for restaurant: Restaurant) -> String { //Begin address formatting function

        guard let location = restaurant.location else {           //Check if restaurant has location data
            return "Address not available"                       //Return fallback if location is missing
        }

        let street = location.address1 ?? ""                      //Get street address or empty string
        let city = location.city ?? ""                            //Get city or empty string
        let state = location.state ?? ""                          //Get state or empty string

        return "\(street), \(city), \(state)"                     //Return formatted address
    }
}


