import Foundation

public enum NetworkResult<T> {
    case success(T)
    case failure(NetworkError)
}

extension NetworkResult {
    func toResult() -> Result<T, NetworkError> {
        switch self {
        case let .success(data):
            return .success(data)
        case let .failure(error):
            return .failure(error)
        }
    }
}

public enum NetworkError: CustomNSError, Error {
    case invalidURL(urlString: String)
    case serializationError(details: String)
    case httpError(statusCode: Int)
    case systemError(error: Error)
    case unknownError

    public var errorDescription: String? {
        switch self {
        case let .invalidURL(urlString):
            return "Invalid URL: \(urlString)"
        case let .serializationError(details):
            return "Serialization Error: \(details)"
        case let .httpError(statusCode):
            return "HTTP Error with status code: \(statusCode)"
        case let .systemError(error):
            return "System Error: \(error.localizedDescription)"
        case .unknownError:
            return "Unknown Error"
        }
    }
}
