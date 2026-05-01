//****************************************************************************************************************************
//Program name: "ContentView.swift".  This file creates the main FoodFinder screen, calls the Yelp API, and displays        *
//restaurant results using RestaurantListView.  Copyright (C) 2026  Jake Miso                                               *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
//****************************************************************************************************************************




//===== Begin code area ====================================================================================================================================================

import SwiftUI                                                   //Import SwiftUI for building the user interface

//==========================================================================================================================================================================
//===== ContentView structure ==============================================================================================================================================
//==========================================================================================================================================================================

struct ContentView: View {                                       //Begin main SwiftUI view

    private let yelpService = YelpService()                      //Create YelpService object used to call Yelp API

    @State private var restaurants: [Restaurant] = []             //Store restaurants returned from Yelp API
    @State private var location: String = "Fullerton"            //Store user location input
    @State private var category: String = "sushi"                //Store user category input
    @State private var statusMessage: String = "Press Search"    //Store message displayed to the user

    var body: some View {                                        //Begin body property

        NavigationStack {                                        //NavigationStack allows NavigationLink to open detail screens

            VStack(spacing: 16) {                                //Place screen components vertically

                Text("FoodFinder")                              //Display app title
                    .font(.largeTitle)                          //Use large title font
                    .fontWeight(.bold)                          //Make title bold

                TextField("Enter location", text: $location)    //Text field for location input
                    .textFieldStyle(.roundedBorder)             //Use rounded border style
                    .padding(.horizontal)                       //Add horizontal spacing

                TextField("Enter category", text: $category)    //Text field for food category input
                    .textFieldStyle(.roundedBorder)             //Use rounded border style
                    .padding(.horizontal)                       //Add horizontal spacing

                Button("Search Restaurants") {                  //Button that starts Yelp search
                    searchRestaurants()                         //Call search helper function
                }
                .padding()                                      //Add padding around button

                Text(statusMessage)                             //Display current API/search status
                    .font(.subheadline)                         //Use smaller font
                    .foregroundColor(.gray)                     //Make status text gray

                RestaurantListView(restaurants: restaurants, category: category)     //Display tappable restaurant results
            }
            .navigationTitle("Restaurant Search")               //Set navigation title
            .toolbar {                                          //Adds a Toolbar button that navigates to FavovoritesView
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink("Favorites") {
                        FavoritesView(category: category)
                    }
                }
            }
        }
    }

    //======================================================================================================================================================================
    //===== Search restaurants function ====================================================================================================================================
    //======================================================================================================================================================================

    private func searchRestaurants() {                          //Begin search function

        statusMessage = "Searching Yelp..."                     //Update status before request starts

        yelpService.searchRestaurants(location: location,        //Send location input to YelpService
                                      category: category) { results in

            DispatchQueue.main.async {                          //Return to main thread before updating UI

                self.restaurants = results                      //Save returned restaurants for List display
                self.statusMessage = "Found \(results.count) restaurants" //Update result count message

                print("Number of restaurants found:", results.count)      //Print result count to console
            }
        }
    }
}

