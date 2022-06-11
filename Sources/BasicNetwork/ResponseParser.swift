import Foundation

class ResponseParser {
    func parseResponse(_ data: Data?, response: URLResponse?, error: Error?, completion: (NetworkResult<Data>) -> Void) {
        if let error = error {
            completion(.failure(.system(error)))
        }
        if let response = response as? HTTPURLResponse, let data = data {
            if (response.statusCode / 100) == 2 {
                completion(.success(data))
            }
        }
    }
}
