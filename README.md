# BasicNetwork

This is a basic HTTP networking library written in Swift.

It supports for now only GET and POST methods.

## Installation
### Swift Package Manager

File > Swift Packages > Add Package Dependency
Add https://github.com/amerexia/BasicNetwork

## Making Requests
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

/// GET Method
httpConnection.get(url, token: "yourToken") { (response) in
switch response {
case let .success(data):
// You can make use of your data
case let .failure(error):
// You can make use of the error
}
}

/// POST Method
httpConnection.post(url, token: nil, body: body, completion: { (response) in
switch response {
case .success:
// You can make use of your data
case let .failure(error):
// You can make use of the error
}
})

/// PUT Method
httpConnection.put(url, token: "yourToken", body: body) { result in
    switch result {
    case .success(let data):
// You can make use of your data
    case .failure(let error):
// You can make use of the error
    }
}

/// DELETE Method
httpConnection.delete(url, token: "yourToken") { result in
    switch result {
    case .success(let data):
// You can make use of your data
    case .failure(let error):
// You can make use of the error
    }
}
```
