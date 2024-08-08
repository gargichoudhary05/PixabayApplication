
struct ImageData: Codable {
  let id: Int
  let webformatURL: String
  let largeImageURL: String
  let tags: String
  let user: String
  let userImageURL: String
}

struct Response: Codable {
  let total: Int
  let totalHits: Int
  let hits: [ImageData]
}
