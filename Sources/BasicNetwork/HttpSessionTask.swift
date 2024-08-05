import Foundation

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
