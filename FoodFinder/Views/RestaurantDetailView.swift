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
            
            if let url = chosenRestaurant.url {
                Text("Website: \(url) ")
                    .font(.subheadline)
            }
            
            if let location = chosenRestaurant.location, let address = location.address1, let city = location.city, let state = location.state, let zip = location.zip_code {
                Text(address)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(city)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(state)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(zip)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
        }
    }
}
