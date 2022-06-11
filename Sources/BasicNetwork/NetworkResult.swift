import Foundation
enum NetworkResult<T> {
    case success(T)
    case failure(NetworkError)
}

enum NetworkError: CustomNSError {
    case debug(String)
    case system(Error)
}
