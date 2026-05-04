//****************************************************************************************************************************
//Program name: "FoodFinderApp.swift".  This file is the entry point of the FoodFinder application.  It initializes the     *
//SwiftUI app and loads the main ContentView when the program starts.                                                        *
//Copyright (C) 2026  Jake Miso                                                                                              *
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
//  Serve as the main entry point of the application and load the initial user interface.
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
//  Apple SwiftUI documentation
//
//Format information
//  Page width: 172 columns
//  Begin comments: 61
//  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
//
//===== Begin code area ====================================================================================================================================================

import SwiftUI                                             //Import SwiftUI framework for building the application UI

//==========================================================================================================================================================================
//===== FoodFinderApp structure ===========================================================================================================================================
//==========================================================================================================================================================================

@main                                                      //Marks this structure as the starting point of the application
struct FoodFinderApp: App {                                 //Define the main application structure conforming to App protocol

    //======================================================================================================================================================================
    //===== Body property ==================================================================================================================================================
    //======================================================================================================================================================================
    //  This property defines the main scene (window) that the app will display when launched.
    //======================================================================================================================================================================

    var body: some Scene {                                  //Define the main scene container

        WindowGroup {                                       //Create a window group for the app (main UI container)

            ContentView()                                   //Load ContentView as the first screen the user sees
        }
    }
}


