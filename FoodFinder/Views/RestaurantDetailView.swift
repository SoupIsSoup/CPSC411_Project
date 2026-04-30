//****************************************************************************************************************************
//Program name: "RestaurantDetailView.swift".  This file displays detailed information about a selected restaurant.         *
//It is presented when the user taps on a restaurant from the list.  Copyright (C) 2026  Jake Miso                         *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied        *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.    *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                          *
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
//  Display detailed information about a selected restaurant, including name, rating, price, phone number,
//  and address.
//
//Project information
//  Files: FoodFinderApp.swift, ContentView.swift, RestaurantListView.swift, RestaurantDetailView.swift,
//         Restaurant.swift, YelpResponse.swift, YelpService.swift, Secrets.swift, Secrets.example.swift
//  Status: In development.
//
//===== Begin code area ====================================================================================================================================================

import SwiftUI                                                   //Import SwiftUI for layout and UI components

//==========================================================================================================================================================================
//===== RestaurantDetailView structure =====================================================================================================================================
//==========================================================================================================================================================================

struct RestaurantDetailView: View {                              //Begin detail view

    //======================================================================================================================================================================
    //===== Stored properties ==============================================================================================================================================
    //======================================================================================================================================================================

    let restaurant: Restaurant                                  //Restaurant passed from list view

    //======================================================================================================================================================================
    //===== Body property ==================================================================================================================================================
    //======================================================================================================================================================================

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            Text(restaurant.name)                               //Restaurant name
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Rating: \(restaurant.rating ?? 0.0)")         //Rating
                .font(.title2)

            Text("Price: \(restaurant.price ?? "N/A")")         //Price
                .font(.title3)

            Text("Phone: \(restaurant.phone ?? "N/A")")         //Phone
                .font(.body)

            Text("Address: \(formatAddress())")                //Address
                .font(.body)

            if let urlString = restaurant.url,                  //Check if Yelp URL exists
               let url = URL(string: urlString) {

                Link("View on Yelp", destination: url)          //Open Yelp page
                    .font(.headline)
                    .foregroundColor(.blue)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Details")
    }

    //======================================================================================================================================================================
    //===== Address formatter ==============================================================================================================================================
//======================================================================================================================================================================

    private func formatAddress() -> String {

        guard let location = restaurant.location else {
            return "Address not available"
        }

        let street = location.address1 ?? ""
        let city = location.city ?? ""
        let state = location.state ?? ""

        return "\(street), \(city), \(state)"
    }
}


