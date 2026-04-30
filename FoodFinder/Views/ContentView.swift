//****************************************************************************************************************************
//Program name: "ContentView.swift".  This file creates the main FoodFinder test screen, calls the Yelp API, and displays    *
//restaurant results on the screen.  Copyright (C) 2026  Jake Miso                                                          *
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
//  Display a simple FoodFinder screen, request restaurant data from Yelp, and show the returned restaurants in a list.
//
//Project information
//  Files: FoodFinderApp.swift, ContentView.swift, Restaurant.swift, YelpResponse.swift, YelpService.swift,
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
    @State private var location: String = "Fullerton"            //Store user location input
    @State private var category: String = "sushi"                //Store user category input
    @State private var statusMessage: String = "Press Search"    //Store message displayed to the user

    //======================================================================================================================================================================
    //===== Body property ==================================================================================================================================================
    //======================================================================================================================================================================

    var body: some View {                                        //Begin body property

        NavigationStack {                                        //Create navigation container

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

                List(restaurants) { restaurant in                //Display restaurants in a scrollable list

                    VStack(alignment: .leading, spacing: 4) {    //Stack restaurant details vertically

                        Text(restaurant.name)                   //Display restaurant name
                            .font(.headline)                    //Use headline font

                        Text("Rating: \(restaurant.rating ?? 0.0)") //Display rating or 0.0 if missing
                            .font(.subheadline)                 //Use smaller font

                        Text(restaurant.price ?? "No price listed") //Display price or fallback text
                            .font(.subheadline)                 //Use smaller font
                            .foregroundColor(.gray)             //Make price text gray
                    }
                    .padding(.vertical, 4)                      //Add vertical spacing inside list row
                }
            }
            .navigationTitle("Restaurant Search")               //Set navigation title
        }
    }

    //======================================================================================================================================================================
    //===== Search restaurants function ====================================================================================================================================
    //======================================================================================================================================================================
    //  This function sends the location and category values to YelpService.
    //  The returned restaurant array is assigned to the restaurants state variable so SwiftUI updates the screen.
    //======================================================================================================================================================================

    private func searchRestaurants() {                          //Begin search function

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

