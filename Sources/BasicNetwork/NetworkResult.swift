import Foundation
public enum NetworkResult<T> {
    case success(T)
    case failure(NetworkError)
}

public enum NetworkError: CustomNSError {
    case debug(String)
    case system(Error)
}
