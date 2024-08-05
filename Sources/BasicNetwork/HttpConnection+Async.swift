import Foundation

@available(macOS 10.15, iOS 13.0, *)
extension HttpConnection {
    
    /// Performs an asynchronous GET request.
    /// - Parameters:
    ///   - urlString: The URL string for the GET request.
    ///   - token: An optional token for authentication.
    /// - Returns: A `Result` containing either the response data or a `NetworkError`.
    public func getAsync(_ urlString: String, token: String? = nil) async -> Result<Data, NetworkError> {
        await withCheckedContinuation { continuation in
            _ = self.get(urlString, token: token) { result in
                continuation.resume(returning: result.toResult())
            }
        }
    }
    
    /// Performs an asynchronous POST request.
    /// - Parameters:
    ///   - urlString: The URL string for the POST request.
    ///   - token: An optional token for authentication.
    ///   - body: The body of the POST request as a dictionary.
    /// - Returns: A `Result` containing either the response data or a `NetworkError`.
    public func postAsync(_ urlString: String, token: String? = nil, body: [String: Any]) async -> Result<Data, NetworkError> {
        await withCheckedContinuation { continuation in
            _ = self.post(urlString, token: token, body: body) { result in
                continuation.resume(returning: result.toResult())
            }
        }
    }
    
    /// Performs an asynchronous PUT request.
    /// - Parameters:
    ///   - urlString: The URL string for the PUT request.
    ///   - token: An optional token for authentication.
    ///   - body: The body of the PUT request as a dictionary.
    /// - Returns: A `Result` containing either the response data or a `NetworkError`.
    public func putAsync(_ urlString: String, token: String? = nil, body: [String: Any]) async -> Result<Data, NetworkError> {
        await withCheckedContinuation { continuation in
            _ = self.put(urlString, token: token, body: body) { result in
                continuation.resume(returning: result.toResult())
            }
        }
    }
    
    /// Performs an asynchronous DELETE request.
    /// - Parameters:
    ///   - urlString: The URL string for the DELETE request.
    ///   - token: An optional token for authentication.
    /// - Returns: A `Result` containing either the response data or a `NetworkError`.
    public func deleteAsync(_ urlString: String, token: String? = nil) async -> Result<Data, NetworkError> {
        await withCheckedContinuation { continuation in
            _ = self.delete(urlString, token: token) { result in
                continuation.resume(returning: result.toResult())
            }
        }
    }
}
