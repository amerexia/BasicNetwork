import Foundation

public protocol HttpSessionProtocol {
    func dataTask(with request: URLRequest, completion: HttpSessionTaskCallback?) -> HttpSessionTask
}

public class HttpSession: HttpSessionProtocol {
    private let urlSession: URLSession
    public init(configuration: URLSessionConfiguration) {
        urlSession = URLSession(configuration: configuration)
    }

    init(configuration: URLSessionConfiguration, delegate: URLSessionTaskDelegate?) {
        urlSession = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
    }

    deinit {
        self.urlSession.invalidateAndCancel()
    }

    public func dataTask(with request: URLRequest, completion: HttpSessionTaskCallback?) -> HttpSessionTask {
        return urlSession.dataTask(with: request, completionHandler: completion ?? { _, _, _ in })
    }
}

public typealias HttpSessionTaskCallback = (Data?, URLResponse?, Error?) -> Void

public protocol HttpSessionTask {
    func cancel()
    func suspend()
    func resume()
    var state: URLSessionTask.State { get }
}

extension URLSessionDataTask: HttpSessionTask { }

enum HttpMethod: String {
    case GET, POST, PUT, DELETE
}
