//
//  Weather.swift
//  MyWeather
//
//  Created by Sicheng Liu on 15/10/25.
//  Copyright © 2015年 liusicheng. All rights reserved.
//

import Foundation
import Alamofire
class Weather{
    
    private var _city: String!
    private var _country: String!
    private var _weatherType: String!
    private var _currentTemp: Int!
    private var _maxTemp: Int!
    private var _minTemp: Int!
    private var _windSpeed: Int!
    private var _rainProb: Int!
    private var _Url : String!
    
    var city:String{
        return _city
    }
    
    var country:String{
        return _country
    }
    
    var weatherType:String{
        return _weatherType
    }
    
    var currentTemp:Int{
        return _currentTemp
    }
    
    var maxTemp:Int{
        return _maxTemp
    }
    
    var minTemp:Int{
        return _minTemp
    }
    
    var windSpeed:Int{
        return _windSpeed
    }
    
    var rainProb:Int{
        return _rainProb
    }
    
    var Url:String{
        return _Url
    }
    
    init(name: String)
    {
        self._city = name
        
        _Url = "\(URL_BASE)\(name)\(KEY)"

        
        
    }
    
    func downloadWeatherDetails(completed: DownloadComplete){
        let url = NSURL(string: _Url)!
       
        //let manager = Alamofire.Manager.sharedInstance
        print("did we call function")
        print(url)
        Alamofire.request(.GET, url).responseJSON{
            response in let result = response.result
            print(result.value)
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let name = dict["name"] as? String{
                    self._city = name
                    print(name)
                }
            }
            completed()
            //print(result)
        }
        
    }
    
    
    
    
    
    
    
    
    
    
}