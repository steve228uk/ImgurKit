//
//  Upload.swift
//  Peach
//
//  Created by Stephen Radford on 24/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Alamofire
import SwiftyJSON

extension Imgur {
    
    /**
     Anonymously upload an image to Imgur.
     
     Note: *There is a filesize limit of 10mb*
     
     - parameter image:    NSData of an image. This will be base64 encoded and uploaded to Imgur.
     - parameter callback: Callback with optional result and NSError
     */
    public class func upload(image: NSData, callback: ((url: String, width: Int, height: Int, type: String)?, NSError?) -> Void) {
        
        Alamofire.request(API.Upload(image))
            .responseJSON { response in
                if response.result.isSuccess {
                    if let value = response.result.value {
                        let json = JSON(value)
                        if let data = json["data"].dictionary {
                            
                            var result = (url: "", width: 0, height: 0, type: "")
                            
                            if let url = data["link"]?.string {
                                result.url = url
                            }
                            
                            if let width = data["width"]?.int {
                                result.width = width
                            }
                            
                            if let height = data["height"]?.int {
                                result.height = height
                            }
                            
                            if let type = data["type"]?.string {
                                result.type = type
                            }
                            
                            callback(result, response.result.error)
                        }
                    }
                } else {
                    callback(nil, response.result.error)
                }
            }
        
    }
    
}