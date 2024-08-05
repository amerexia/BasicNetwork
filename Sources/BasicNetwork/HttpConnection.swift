import Foundation

public class HttpConnection: HttpConnectionProtocol {
    private let session: HttpSessionProtocol
    private let parser: ResponseParser
    private var customHeaders: [HTTPHeaderField: String] = [:]
    
    /// Initializes a new instance of `HttpConnection`.
    /// - Parameter session: The session to be used for HTTP connections. Defaults to an ephemeral session configuration.
    public init(session: HttpSessionProtocol = HttpSession(configuration: URLSessionConfiguration.ephemeral)) {
        self.session = session
        parser = ResponseParser()
    }
    
    /// Sets custom headers for the HTTP requests.
    /// - Parameter headers: A dictionary containing the custom headers.
    public func setCustomHeaders(_ headers: [HTTPHeaderField: String]) {
        customHeaders = headers
    }
    
    private func request(url: URL, httpMethod: HttpMethod, token: String?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        request.addValue("application/json", forHTTPHeaderField: HTTPHeaderField.accept.rawValue)
        if let xToken = token {
            request.addValue("Bearer \(xToken)", forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        }
        
        for (key, value) in customHeaders {
            request.addValue(value, forHTTPHeaderField: key.rawValue)
        }
        
        return request
    }
    
    /// Performs a GET request.
    /// - Parameters:
    ///   - urlString: The URL string for the GET request.
    ///   - token: An optional token for authentication.
    ///   - completion: A completion handler that returns a `NetworkResult` containing either the response data or a `NetworkError`.
    /// - Returns: An optional `HttpSessionTask` for the GET request.
    public func get(_ urlString: String, token: String? = nil, completion: @escaping (NetworkResult<Data>) -> Void) -> HttpSessionTask? {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL(urlString: urlString)))
            return nil
        }
        
        let request = self.request(url: url, httpMethod: .GET, token: token)
        return executeTask(request, completion: completion)
    }
    
    /// Performs a POST request.
    /// - Parameters:
    ///   - urlString: The URL string for the POST request.
    ///   - token: An optional token for authentication.
    ///   - body: The body of the POST request as a dictionary.
    ///   - completion: A completion handler that returns a `NetworkResult` containing either the response data or a `NetworkError`.
    /// - Returns: An optional `HttpSessionTask` for the POST request.
    public func post(_ urlString: String, token: String? = nil, body: [String: Any], completion: @escaping (NetworkResult<Data>) -> Void) -> HttpSessionTask? {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL(urlString: urlString)))
            return nil
        }
        
        var request = self.request(url: url, httpMethod: .POST, token: token)
        guard let stringBody = self.body(body) else {
            completion(.failure(.serializationError(details: "Failed to serialize request body")))
            return nil
        }
        request.httpBody = stringBody.data(using: String.Encoding.utf8)
        return executeTask(request, completion: completion)
    }
    
    /// Performs a PUT request.
    /// - Parameters:
    ///   - urlString: The URL string for the PUT request.
    ///   - token: An optional token for authentication.
    ///   - body: The body of the PUT request as a dictionary.
    ///   - completion: A completion handler that returns a `NetworkResult` containing either the response data or a `NetworkError`.
    /// - Returns: An optional `HttpSessionTask` for the PUT request.
    public func put(_ urlString: String, token: String? = nil, body: [String: Any], completion: @escaping (NetworkResult<Data>) -> Void) -> HttpSessionTask? {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL(urlString: urlString)))
            return nil
        }
        
        var request = self.request(url: url, httpMethod: .PUT, token: token)
        guard let stringBody = self.body(body) else {
            completion(.failure(.serializationError(details: "Failed to serialize request body")))
            return nil
        }
        request.httpBody = stringBody.data(using: String.Encoding.utf8)
        return executeTask(request, completion: completion)
    }
    
    /// Performs a DELETE request.
    /// - Parameters:
    ///   - urlString: The URL string for the DELETE request.
    ///   - token: An optional token for authentication.
    ///   - completion: A completion handler that returns a `NetworkResult` containing either the response data or a `NetworkError`.
    /// - Returns: An optional `HttpSessionTask` for the DELETE request.
    public func delete(_ urlString: String, token: String? = nil, completion: @escaping (NetworkResult<Data>) -> Void) -> HttpSessionTask? {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL(urlString: urlString)))
            return nil
        }
        
        let request = self.request(url: url, httpMethod: .DELETE, token: token)
        return executeTask(request, completion: completion)
    }
    
    private func body(_ body: [String: Any]) -> String? {
        do {
            return try String(data: JSONSerialization.data(withJSONObject: body, options: []), encoding: .utf8)
        } catch {
            return nil
        }
    }
    
    private func executeTask(_ request: URLRequest, completion: @escaping (NetworkResult<Data>) -> Void) -> HttpSessionTask {
        let task = session.dataTask(with: request) { data, response, error in
            self.parser.parseResponse(data, response: response, error: error, completion: completion)
        }
        task.resume()
        return task
    }
}
