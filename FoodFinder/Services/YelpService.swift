//****************************************************************************************************************************
//Program name: "YelpService.swift".  This file communicates with the Yelp API, sends restaurant search requests, and decodes *
//the JSON response into Swift objects.  Copyright (C) 2026  Jake Miso                                                       *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
//****************************************************************************************************************************




//===== Begin code area ====================================================================================================================================================

import Foundation                                             //Import Foundation for URL, URLRequest, URLSession, and JSONDecoder

//==========================================================================================================================================================================
//===== YelpService class declaration ======================================================================================================================================
//==========================================================================================================================================================================

class YelpService {                                           //Begin YelpService class

    //======================================================================================================================================================================
    //===== Stored properties ==============================================================================================================================================
    //======================================================================================================================================================================

    private let baseURL = "https://api.yelp.com/v3/businesses/search" //Yelp Business Search endpoint

    private let apiKey = Secrets.yelpAPIKey                   //Private Yelp API key stored in Secrets.swift

    //======================================================================================================================================================================
    //===== Search restaurants using Yelp API ==============================================================================================================================
    //======================================================================================================================================================================
    //  This function receives a location and restaurant category, builds a Yelp API request, sends the request,
    //  decodes the JSON response, and returns an array of Restaurant objects through the completion closure.
    //======================================================================================================================================================================

    func searchRestaurants(location: String,
                           category: String,
                           completion: @escaping ([Restaurant]) -> Void) {

        let encodedLocation = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "" //Make location URL-safe
        let encodedCategory = category.lowercased().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "" //Make category URL-safe

        let query = "location=\(encodedLocation)&categories=\(encodedCategory)" //Create Yelp query string
        let urlString = "\(baseURL)?\(query)"                    //Combine endpoint and query string

        guard let url = URL(string: urlString) else {             //Validate URL creation
            print("Error: Invalid URL")                          //Print URL error
            completion([])                                       //Return empty list
            return                                               //Stop function
        }

        var request = URLRequest(url: url)                        //Create HTTP request
        request.httpMethod = "GET"                               //Yelp search uses GET request
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization") //Attach Yelp API key

        URLSession.shared.dataTask(with: request) { data, response, error in //Begin asynchronous network call

            if let error = error {                               //Check for networking error
                print("Network error:", error)                   //Print network error
                completion([])                                   //Return empty restaurant list
                return                                           //Stop processing
            }

            guard let data = data else {                         //Check that response data exists
                print("Error: No data received")                 //Print missing data error
                completion([])                                   //Return empty restaurant list
                return                                           //Stop processing
            }

            do {                                                 //Begin JSON decoding attempt
                let decodedResponse = try JSONDecoder().decode(YelpResponse.self, from: data) //Decode JSON response
                completion(decodedResponse.businesses)           //Return decoded restaurants
            } catch {                                            //Handle decoding failure
                print("JSON decoding error:", error)             //Print decoding error
                completion([])                                   //Return empty restaurant list
            }

        }.resume()                                               //Start network request
    }
}

