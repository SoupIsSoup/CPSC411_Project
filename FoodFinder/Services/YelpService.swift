//****************************************************************************************************************************
//Program name: "YelpService.swift".  This file communicates with the Yelp API, sends restaurant search requests, and decodes *
//the JSON response into Swift objects.  Copyright (C) 2026  Jake Miso                                                       *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
//****************************************************************************************************************************




//========1=========2=========3=========4=========5=========0=========1=========2=========3=========4=========5=========6
//Author information
//  Author name: Jake Miso
//  Author email: jamiso@csu.fullerton.edu
//
//Program information
//  Program name: FoodFinder
//  Programming language: Swift
//  Date development of program began 2026-Mar-26
//  Date development of program completed TBD
//
//Purpose
//  Send a restaurant search request to Yelp using the location and category entered by the user, receive the JSON response,
//  decode the response into Swift model objects, and return the restaurants to the view layer.
//
//Project information
//  Files: FoodFinderApp.swift, ContentView.swift, RestaurantListView.swift, RestaurantDetailView.swift,
//         FavoritesView.swift, Restaurant.swift, YelpResponse.swift, YelpService.swift, FavoritesManager.swift,
//         Secrets.example.swift
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
//===== Begin code area ====================================================================================================

import Foundation                                             //Import Foundation for URL, URLRequest, URLSession, and JSONDecoder

//==========================================================================================================================
//===== YelpService class declaration ======================================================================================
//===========================================================================================================================

class YelpService {                                           //Begin YelpService class

    //=======================================================================================================================
    //===== Stored properties ===============================================================================================
    //=======================================================================================================================

    private let baseURL = "https://api.yelp.com/v3/businesses/search"    //Yelp Business Search endpoint

    private let apiKey = Secrets.yelpAPIKey                              //Private Yelp API key stored outside GitHub

    //==============================================================================================================
    //===== Search restaurants using Yelp API =======================================================================
    //==============================================================================================================
    //  This function receives a location and a restaurant category, builds a Yelp API request, sends the request,
    //  decodes the JSON response, and returns an array of Restaurant objects through the completion closure.
    //=======================================================================================================================
    func searchRestaurants(location: String,
                           category: String,
                           completion: @escaping ([Restaurant]) -> Void) {

        let encodedLocation = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""    //Make location URL-safe
        let encodedCategory = category.lowercased().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""    //Make category URL-safe

        let query = "location=\(encodedLocation)&categories=\(encodedCategory)"                               //Create query string
        let urlString = "\(baseURL)?\(query)"                                                                  //Combine endpoint and query

        guard let url = URL(string: urlString) else {                                                          //Validate URL creation
            print("Error: Invalid URL")                                                                       //Print error for debugging
            completion([])                                                                                    //Return empty list if URL is invalid
            return                                                                                            //Stop the function
        }

        var request = URLRequest(url: url)                                                                     //Create HTTP request object
        request.httpMethod = "GET"                                                                            //Yelp search uses GET request
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")                             //Attach Yelp API key

        URLSession.shared.dataTask(with: request) { data, response, error in                                   //Begin asynchronous network call

            if let error = error {                                                                            //Check if URLSession returned an error
                print("Network error:", error)                                                                //Print network error
                completion([])                                                                                //Return empty restaurant list
                return                                                                                        //Stop processing
            }

            guard let data = data else {                                                                      //Verify that response data exists
                print("Error: No data received")                                                             //Print missing data error
                completion([])                                                                                //Return empty restaurant list
                return                                                                                        //Stop processing
            }

            do {                                                                                              //Begin JSON decoding attempt
                let decodedResponse = try JSONDecoder().decode(YelpResponse.self, from: data)                  //Decode JSON into YelpResponse
                completion(decodedResponse.businesses)                                                        //Return decoded restaurant array
            } catch {                                                                                         //Handle decoding failure
                print("JSON decoding error:", error)                                                          //Print decoding error
                completion([])                                                                                //Return empty restaurant list
            }

        }.resume()                                                                                            //Start the URLSession task
    }
}
