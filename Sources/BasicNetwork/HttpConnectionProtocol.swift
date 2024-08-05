import Foundation

protocol HttpConnectionProtocol {
    func get(_ urlString: String, token: String?, completion: @escaping (NetworkResult<Data>) -> Void) -> HttpSessionTask?
    func post(_ urlString: String, token: String?, body: [String: Any], completion: @escaping (NetworkResult<Data>) -> Void) -> HttpSessionTask?
    func put(_ urlString: String, token: String?, body: [String: Any], completion: @escaping (NetworkResult<Data>) -> Void) -> HttpSessionTask?
    func delete(_ urlString: String, token: String?, completion: @escaping (NetworkResult<Data>) -> Void) -> HttpSessionTask?
    func setCustomHeaders(_ headers: [HTTPHeaderField: String])
}
