//
//  ViewController.swift
//  IOSpreTask
//
//  Created by Oscar on 2018-12-30.
//  Copyright © 2018 Oscar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Mark: Properties
    @IBOutlet weak var TempretureTextField: UITextField!
    
    static let baseURL = "https://api.openweathermap.org/data/2.5/weather?id="
    static let APIid = "&APPID=83f3f819b24217818d61eedbba2e192d"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func ShowTempreture(_ sender: UIButton) {
        getweather(id:"4699066")
    }
    
    
    func getweather(id: String)->(){
        let url = ViewController.baseURL + id + ViewController.APIid
        let request = URLRequest(url:URL(string: url)!)
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print("Error:\n\(error)")
            } else {
                if let data = data {
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                        if let mainDictionary = jsonObj!.value(forKey: "main") as? NSDictionary {
                            if let temperature = mainDictionary.value(forKey: "temp") {
                                DispatchQueue.main.async {
                                    self.TempretureTextField.text = "Houston Temperature: \(temperature)°F"
                                }
                            }
                        } else {
                            print("Error: can't find tempreture")
                        }
                    } else {
                        print("Error: can't convert data")
                    }
                } else {
                    print("Error: no data received")
                }
            }
        }
        
        dataTask.resume()
    }

}

