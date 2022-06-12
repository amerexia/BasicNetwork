import Foundation

protocol HttpConnectionProtocol {
    func get(_ urlString: String, token: String?, completion: @escaping (NetworkResult<Data>) -> Void) -> HttpSessionTask?
    func post(_ urlString: String, token: String?, body: [String: Any], completion: @escaping (NetworkResult<Data>) -> Void) -> HttpSessionTask?
}
public class HttpConnection: HttpConnectionProtocol {
    private let session: HttpSessionProtocol
    private let parser: ResponseParser
    
    public init(session: HttpSessionProtocol = HttpSession(configuration: URLSessionConfiguration.ephemeral)) {
        self.session = session
        self.parser = ResponseParser()
    }
    private func request(url: URL, httpMethod: HttpMethod, token: String?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if let xToken = token {
            request.addValue("Bearer \(xToken)", forHTTPHeaderField: "x-token")
        }
        return request
    }
    public func get(_ urlString: String, token: String? = nil, completion: @escaping (NetworkResult<Data>) -> Void) -> HttpSessionTask? {
        guard let url = URL(string: urlString) else {
            completion(.failure(.debug("Invalid url: \(urlString)")))
            return nil
        }
        
        let request = self.request(url: url, httpMethod: .GET, token: token)
        return executeTask(request, completion: completion)
    }
    
    public func post(_ urlString: String, token: String? = nil, body: [String: Any], completion: @escaping (NetworkResult<Data>) -> Void) -> HttpSessionTask? {
        guard let url = URL(string: urlString) else {
            completion(.failure(.debug("Invalid url: \(urlString)")))
            return nil
        }
        
        var request = self.request(url: url, httpMethod: .POST, token: token)
        let stringBody = self.body(body)
        request.httpBody = stringBody?.data(using: String.Encoding.utf8)
        return executeTask(request, completion: completion)
    }
    private func body(_ body: [String: Any]) -> String? {
        var jsonBody: String?
        do {
            jsonBody = try String(data: JSONSerialization.data(withJSONObject: body, options: []), encoding: .utf8)
        } catch _ {
            print("Couldn't serialise request body")
        }
        return jsonBody
    }
    private func executeTask(_ request: URLRequest, completion: @escaping (NetworkResult<Data>) -> Void) -> HttpSessionTask {
        let request = request
        let task = self.session.dataTask(with: request) { data, response, error in
            self.parser.parseResponse(data, response: response, error: error, completion: completion)
        }
        task.resume()
        return task
    }
}
