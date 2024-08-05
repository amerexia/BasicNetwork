import Foundation

internal class ResponseParser {
    func parseResponse(_ data: Data?, response: URLResponse?, error: Error?, completion: (NetworkResult<Data>) -> Void) {
        if let error = error {
            completion(.failure(.systemError(error: error)))
            return
        }
        
        if let response = response as? HTTPURLResponse {
            if (response.statusCode / 100) == 2 {
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(.unknownError))
                }
            } else {
                completion(.failure(.httpError(statusCode: response.statusCode)))
            }
        } else {
            completion(.failure(.unknownError))
        }
    }
}
