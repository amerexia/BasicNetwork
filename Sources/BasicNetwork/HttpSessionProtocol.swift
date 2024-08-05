import Foundation

public protocol HttpSessionProtocol {
    func dataTask(with request: URLRequest, completion: HttpSessionTaskCallback?) -> HttpSessionTask
}
