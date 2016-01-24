# ImgurKit
**Upload anonymously to Imgur**

## Requirements

Requires Alamofire and SwiftyJSON. No podspec currently included as this is a submodule of a larger project.

## Usage

````Swift
Imgur.clientID = "yourIDHere"

let data = NSData()

Imgur.upload(data) { response, error in

    print(response)
    print(error)

}
````
