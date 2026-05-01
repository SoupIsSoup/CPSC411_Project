import SwiftUI

struct RestaurantDetailView: View{
    
    let chosenRestaurant: Restaurant
    
    var body: some View{
        VStack(alignment: .leading){
            Text(chosenRestaurant.name)
                .font(.headline)
            
            if let rating = chosenRestaurant.rating {
                Text("Rating: \(rating, specifier: "%.1f") ⭐")
                    .font(.subheadline)
            }
            
            if let price = chosenRestaurant.price {
                Text("Price: \(price) ")
                    .font(.subheadline)
            }
            
            if let phoneNumber = chosenRestaurant.phone {
                Text("Phone Number: \(phoneNumber) ")
                    .font(.subheadline)
            }
            
            if let urlString = chosenRestaurant.url, let url = URL(string: urlString) {
                Link("Visit \(chosenRestaurant.name) on Yelp!", destination: url)
                    .font(.subheadline)
            }
            
            if let location = chosenRestaurant.location {
                Text([location.address1, location.city, location.state, location.zip_code]
                    //compact map removes nl values fro the array and unwraps String? to String
                     //$0 is the current element in the closure
                    .compactMap { $0 }
                    .joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}
