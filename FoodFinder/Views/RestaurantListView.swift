import SwiftUI

struct RestaurantListView: View {
    //When ContentView creates this view, passes the array of restos here
    let restaurants: [Restaurant]

    var body: some View {
        //Iterate over restaurants and each item is a restaurant object
        //When the array is empty List renders an empty list
        List(restaurants) { restaurant in
            //makes each list item a NavigationLink
            //when clicked, creates a RestaurantDetailView with the specific restaurant object from the clicked row
            NavigationLink(destination: RestaurantDetailView(chosenRestaurant: restaurant)){
                VStack(alignment: .leading) {
                    Text(restaurant.name)
                        .font(.headline)
                    
                    //optional binding because these values are optionals in Restaurant. If nil, code block is skipped
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
}
