import SwiftUI

struct ContentView: View {
    
    @State private var searchLocation = ""
    @State private var searchCategory = ""
    
    //Creates a state variable that holds an array of Restaurant objects
    @State private var restaurants: [Restaurant] = []
    
    //Creates an instance of the YelpService class (for the purposes of using its searchRestaurants function)
    private let yelpService = YelpService()
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Welcome to The Food Finder App!")
                    .font(.title)
                    .fontWeight(.bold)
                
                TextField("Enter your location", text: $searchLocation)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                TextField("Enter a food category", text: $searchCategory)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                Button("Search") {
                    yelpService.searchRestaurants(location: searchLocation,
                    //results will be the incoming value from searchRestaurants
                    category: searchCategory) { results in
                    //DispatchQueue.main.async makes the code run on the main thread since restaurants is a state variable
                        DispatchQueue.main.async {
                            restaurants = results
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
                
                RestaurantListView(restaurants: restaurants)
            }
            .padding()
        }
    }
}
/*
#Preview {
    ContentView()
}*/
