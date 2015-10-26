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
    private var _currentTemp: String!
    private var _maxTemp: String!
    private var _minTemp: String!
    private var _windSpeed: String!
    private var _humidity: String!
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
    
    var currentTemp:String{
        return _currentTemp
    }
    
    var maxTemp:String{
        return _maxTemp
    }
    
    var minTemp:String{
        return _minTemp
    }
    
    var windSpeed:String{
        return _windSpeed
    }
    
    var humidity:String{
        return _humidity
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
                //City
                if let name = dict["name"] as? String{
                    self._city = name
                    print(name)
                }
                //Country
                if let sys = dict["sys"] as? Dictionary<String,AnyObject>{
                    if let country = sys["country"] as? String{
                    self._country = country
                    print(self._country)
                    }
                }
                //if let weather
                //currentTemp
                if let currentTemp = dict["main"] as? Dictionary<String,AnyObject>{
                    if let temp = currentTemp["temp"] as? Int{
                      self._currentTemp = "\(temp)°F"
                      print(self._currentTemp)
                    }
                    
                }
                
            }
            completed()
            //print(result)
        }
        
    }
    
    
    
    
    
    
    
    
    
    
}