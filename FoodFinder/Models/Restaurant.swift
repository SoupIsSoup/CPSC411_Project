import Foundation

struct Restaurant: Identifiable, Codable {
    let id: String
    let name: String
    let image_url: String?
    let rating: Double?
    let price: String?
    let phone: String?
    let url: String?
    let location: YelpLocation?
}
