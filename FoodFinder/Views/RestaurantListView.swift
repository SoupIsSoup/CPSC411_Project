//****************************************************************************************************************************
//Program name: "RestaurantListView.swift".  This file displays restaurant search results in a scrollable list.  Each row    *
//shows basic restaurant information returned from the Yelp API and allows navigation to a detail screen.                   *
//Copyright (C) 2026  Jake Miso                                                                                              *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied        *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.    *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                          *
//****************************************************************************************************************************




//===== Begin code area ====================================================================================================================================================

import SwiftUI                                                   //Import SwiftUI for List, NavigationLink, VStack, and layout tools

//==========================================================================================================================================================================
//===== RestaurantListView structure =======================================================================================================================================
//==========================================================================================================================================================================

struct RestaurantListView: View {                                //Begin RestaurantListView structure

    let restaurants: [Restaurant]                                //Restaurant array received from ContentView
    let category: String                                         //Category received from ContentView

    var body: some View {                                        //Begin body property

        List(restaurants) { restaurant in                        //Create a list row for each Restaurant object

            NavigationLink(destination: RestaurantDetailView(restaurant: restaurant, category: category)) { //Make row tappable

                VStack(alignment: .leading, spacing: 6) {        //Display restaurant info inside row

                    Text(restaurant.name)                        //Restaurant name
                        .font(.headline)

                    Text("Rating: \(restaurant.rating ?? 0.0, specifier: "%.1f") ⭐") //Rating
                        .font(.subheadline)

                    Text(restaurant.price ?? "No price listed") //Price
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text(formatAddress(for: restaurant))         //Address
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 6)
            }
        }
    }

    //======================================================================================================================================================================
    //===== Format address helper function =================================================================================================================================
    //======================================================================================================================================================================

    private func formatAddress(for restaurant: Restaurant) -> String {

        guard let location = restaurant.location else {
            return "Address not available"
        }

        let street = location.address1 ?? ""
        let city = location.city ?? ""
        let state = location.state ?? ""

        return "\(street), \(city), \(state)"
    }
}

