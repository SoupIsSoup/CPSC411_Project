//****************************************************************************************************************************
//Program name: "ContentView.swift".  This file creates the main FoodFinder screen, calls the Yelp API, displays restaurant *
//results using RestaurantListView, and provides navigation to the Favorites screen.  Copyright (C) 2026  Jake Miso         *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
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
//  Display the main search screen, allow the user to search Yelp restaurants, show restaurant results,
//  and navigate to the Favorites screen.
//
//Project information
//  Files: FoodFinderApp.swift, ContentView.swift, RestaurantListView.swift, RestaurantDetailView.swift,
//         FavoritesView.swift, Restaurant.swift, YelpResponse.swift, YelpService.swift, FavoritesManager.swift,
//         Secrets.swift, Secrets.example.swift
//  Status: In development.
//
//Translator information
//  Apple macOS: Xcode with Swift compiler
//
//References and credits
//  CPSC 411 course examples
//  Yelp Fusion API documentation
//
//Format information
//  Page width: 172 columns
//  Begin comments: 61
//  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
//
//===== Begin code area ====================================================================================================================================================

import SwiftUI                                                   //Import SwiftUI for building the user interface

//==========================================================================================================================================================================
//===== ContentView structure ==============================================================================================================================================
//==========================================================================================================================================================================

struct ContentView: View {                                       //Begin main SwiftUI view

    //======================================================================================================================================================================
    //===== Stored properties ==============================================================================================================================================
    //======================================================================================================================================================================

    private let yelpService = YelpService()                      //Create YelpService object used to call Yelp API

    @State private var restaurants: [Restaurant] = []             //Store restaurants returned from Yelp API
    @State private var location: String = ""                     //Start location input empty
    @State private var category: String = ""                     //Start category input empty
    @State private var statusMessage: String = ""                //Start status message empty

    //======================================================================================================================================================================
    //===== Body property ==================================================================================================================================================
    //======================================================================================================================================================================

    var body: some View {                                        //Begin body property

        NavigationStack {                                        //Create navigation container for detail and favorites screens

            VStack(spacing: 16) {                                //Place screen components vertically

                Text("FoodFinder")                              //Display app title
                    .font(.largeTitle)                          //Use large title font
                    .fontWeight(.bold)                          //Make title bold

                TextField("Enter location", text: $location)    //Create text field for location input
                    .textFieldStyle(.roundedBorder)             //Use rounded border style
                    .padding(.horizontal)                       //Add horizontal spacing

                TextField("Enter category", text: $category)    //Create text field for food category input
                    .textFieldStyle(.roundedBorder)             //Use rounded border style
                    .padding(.horizontal)                       //Add horizontal spacing

                Button("Search Restaurants") {                  //Create button that starts Yelp search
                    searchRestaurants()                         //Call search helper function
                }
                .padding()                                      //Add padding around search button

                NavigationLink(destination: FavoritesView()) {   //Create navigation link to FavoritesView

                    Text("View Favorites")                      //Display button-style text for favorites screen
                        .frame(maxWidth: .infinity)             //Make favorites button stretch horizontally
                        .padding()                              //Add spacing inside the button
                        .background(Color.green)                //Set background color for favorites button
                        .foregroundColor(.white)                //Set text color to white
                        .cornerRadius(8)                        //Round the button corners
                }
                .padding(.horizontal)                           //Add horizontal spacing around favorites button

                Text(statusMessage)                             //Display current API/search status
                    .font(.subheadline)                         //Use smaller font
                    .foregroundColor(.gray)                     //Make status text gray

                RestaurantListView(restaurants: restaurants)     //Display tappable restaurant results in separate view
            }
            .navigationTitle("Restaurant Search")               //Set navigation bar title
        }
    }

    //======================================================================================================================================================================
    //===== Search restaurants function ====================================================================================================================================
    //======================================================================================================================================================================
    //  This function checks that the user entered a location and category before calling YelpService.
    //======================================================================================================================================================================

    private func searchRestaurants() {                          //Begin search function

        if location.isEmpty || category.isEmpty {                //Check if either text field is empty
            statusMessage = "Please enter a location and category." //Tell user both fields are required
            restaurants = []                                    //Clear old restaurant results
            return                                              //Stop function before API call
        }

        statusMessage = "Searching Yelp..."                     //Update status before request starts

        yelpService.searchRestaurants(location: location,        //Send location input to YelpService
                                      category: category) { results in

            DispatchQueue.main.async {                          //Return to main thread before updating UI

                self.restaurants = results                      //Save returned restaurants for List display

                self.statusMessage = "Found \(results.count) restaurants" //Update result count message

                print("Number of restaurants found:", results.count)      //Print result count to console

                for restaurant in results {                     //Loop through all returned restaurants
                    print("Restaurant:", restaurant.name)        //Print each restaurant name
                }
            }
        }
    }
}


