import Foundation

struct YelpResponse: Codable {
    let businesses: [Restaurant]
}

struct YelpLocation: Codable {
    let address1: String?
    let city: String?
    let state: String?
    let zip_code: String?
}
