# BasicNetwork

This is a basic HTTP networking library written in Swift.

It supports HTTP methods: GET, POST, PUT, and DELETE. The library now also includes support for modern asynchronous requests using Swift's `async/await` syntax.

## Installation

### Swift Package Manager

To add this package to your project:

1. Go to `File > Swift Packages > Add Package Dependency`.
2. Enter `https://github.com/amerexia/BasicNetwork` in the search field.

## Making Requests

### Callback-Based API

For environments where `async/await` isn't available or when you prefer using completion handlers, the library provides a callback-based API for making HTTP requests:

```swift
let httpConnection = HttpConnection()
let url = "https://httpbin.org/"

// Define custom headers
let customHeaders = [
    "Custom-Header-1": "Value1",
    "Custom-Header-2": "Value2"
]

// Set the custom headers
httpConnection.setCustomHeaders(customHeaders)

/// GET Request
httpConnection.get(url, token: "yourToken") { response in
    switch response {
    case let .success(data):
        // Handle successful response with data
    case let .failure(error):
        // Handle error
    }
}

/// POST Request
httpConnection.post(url, token: nil, body: body) { response in
    switch response {
    case .success(let data):
        // Handle successful response with data
    case let .failure(error):
        // Handle error
    }
}

/// PUT Request
httpConnection.put(url, token: "yourToken", body: body) { response in
    switch response {
    case .success(let data):
        // Handle successful response with data
    case .failure(let error):
        // Handle error
    }
}

/// DELETE Request
httpConnection.delete(url, token: "yourToken") { response in
    switch response {
    case .success(let data):
        // Handle successful response with data
    case .failure(let error):
        // Handle error
    }
}
```

### Async/Await API

For modern Swift environments (iOS 13.0+, macOS 10.15+), the library provides an API leveraging async/await for cleaner, more readable asynchronous code:

```swift
let httpConnection = HttpConnection()
let url = "https://httpbin.org/"

do {
    /// GET Request
    let getResult = await httpConnection.getAsync(url, token: "yourToken")
    switch getResult {
    case .success(let data):
        // Handle successful response with data
    case .failure(let error):
        // Handle error
    }
    
    /// POST Request
    let postResult = await httpConnection.postAsync(url, token: nil, body: body)
    switch postResult {
    case .success(let data):
        // Handle successful response with data
    case .failure(let error):
        // Handle error
    }
    
    /// PUT Request
    let putResult = await httpConnection.putAsync(url, token: "yourToken", body: body)
    switch putResult {
    case .success(let data):
        // Handle successful response with data
    case .failure(let error):
        // Handle error
    }
    
    /// DELETE Request
    let deleteResult = await httpConnection.deleteAsync(url, token: "yourToken")
    switch deleteResult {
    case .success(let data):
        // Handle successful response with data
    case .failure(let error):
        // Handle error
    }
    
} catch {
    // Handle any unexpected errors
}
```

### Error Handling

All methods return a Result<Data, NetworkError> or its async equivalent, allowing you to handle success and failure cases distinctly. The NetworkError enum covers common networking errors such as invalid URLs, serialization issues, HTTP status code errors, and system errors.
