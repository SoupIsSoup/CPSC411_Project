import SwiftUI

struct RestaurantListView: View {
    let restaurants: [Restaurant]

    var body: some View {
        List(restaurants) { restaurant in
            VStack(alignment: .leading) {
                Text(restaurant.name)
                    .font(.headline)

                if let location = restaurant.location, let city = location.city {
                    Text(city)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                if let rating = restaurant.rating {
                    Text("Rating: \(rating, specifier: "%.1f") ⭐")
                        .font(.subheadline)
                }
            }
        }
    }
}
