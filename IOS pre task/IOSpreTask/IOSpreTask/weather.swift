//
//  weather.swift
//  IOSpreTask
//
//  Created by Oscar on 2018-12-31.
//  Copyright © 2018 Oscar. All rights reserved.
//

import Foundation

class weather{
    var temperature : Double = 0

    // throws error (used in unit tests)
    enum SerializationError : Error{
        case missing(String)
        case invalid(String,Any)
    }
    
    
    
    init(id: String){
      let baseURL = "https://api.openweathermap.org/data/2.5/weather?id="
      let APIid = "&APPID=83f3f819b24217818d61eedbba2e192d"
    
        let url = baseURL + id + APIid
        let request = URLRequest(url:URL(string: url)!)
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                self.temperature = -400
            } else {
            if let data = data {
                if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                    if let mainDictionary = jsonObj!.value(forKey: "main") as? NSDictionary {
                        if let temperature1 = mainDictionary.value(forKey: "temp") {
                            DispatchQueue.main.async {
                                // The point that might cause the test fail
                                self.temperature = temperature1 as! Double
                            }
                        }
                    } else {
                       // print("Error: can't find tempreture")
                        self.temperature = -100
                    }
                } else {
                   // print("Error: can't convert data")
                    self.temperature = -200
                }
            } else {
                //print("Error: no data received")
                self.temperature = -300
            }
           }
        }
        dataTask.resume()
    }

}

