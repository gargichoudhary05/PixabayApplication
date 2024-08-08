import Foundation
protocol ImageNetworkingProtocol {
    func getImagesData(query: String, page: Int, completion: @escaping (Result<[ImageData], Error>) -> Void)
}

class Networking: ImageNetworkingProtocol {
    func getImagesData(query: String, page: Int, completion: @escaping (Result<[ImageData], Error>) -> Void) {
        let apiKey = "5687323-fe96d5c027bc470b3bc407e05"
        let urlString = "https://pixabay.com/api/?key=\(apiKey)&q=\(query)&image_type=photo&pretty=true&page=\(page)"

        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: 0, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let pixabayResponse = try decoder.decode(Response.self, from: data)

                completion(.success(pixabayResponse.hits))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
