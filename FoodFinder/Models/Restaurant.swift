//****************************************************************************************************************************
//Program name: "Restaurant.swift".  This file defines the Restaurant model used to store business data returned by the Yelp  *
//API.  Copyright (C) 2026  Jake Miso                                                                                        *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
//****************************************************************************************************************************




//===== Begin code area ====================================================================================================================================================

import Foundation                                             //Import Foundation for Codable support

//==========================================================================================================================================================================
//===== Restaurant structure ===============================================================================================================================================
//==========================================================================================================================================================================

nonisolated struct Restaurant: Identifiable, Codable {         //Define one Yelp restaurant/business object

    let id: String                                             //Unique Yelp business identifier
    let name: String                                           //Restaurant name
    let image_url: String?                                     //Optional restaurant image URL
    let rating: Double?                                        //Optional Yelp rating
    let price: String?                                         //Optional price string, such as "$$"
    let phone: String?                                         //Optional phone number
    let url: String?                                           //Optional Yelp page URL
    let location: YelpLocation?                                //Optional restaurant location object
}


