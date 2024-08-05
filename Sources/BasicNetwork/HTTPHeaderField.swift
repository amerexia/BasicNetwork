import Foundation

public enum HTTPHeaderField: Hashable {
    case contentType
    case accept
    case authorization
    case userAgent
    case cacheControl
    case custom(String)
    
    var rawValue: String {
        switch self {
        case .contentType:
            return "Content-Type"
        case .accept:
            return "Accept"
        case .authorization:
            return "Authorization"
        case .userAgent:
            return "User-Agent"
        case .cacheControl:
            return "Cache-Control"
        case .custom(let value):
            return value
        }
    }
}
