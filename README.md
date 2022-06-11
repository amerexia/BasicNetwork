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

/// GET Method
httpConnection.get(url, token: nil) { (response) in
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
```
