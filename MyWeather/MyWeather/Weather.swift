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
    private var _currentUrl : String!
    private var _forcastUrl : String!
    
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
    
    var currentUrl:String{
        return _currentUrl
    }
    
    var forcastUrl:String{
        return _forcastUrl
    }
    
    init(name: String)
    {
        self._city = name
        let url = URL_BASE+self._city+KEY
        _currentUrl = url
        _forcastUrl = URL_BASE+self._city+URL_FORCAST
        
        
    }
    
    func downloadWeatherDetails(completed: DownloadComplete){
        let url = NSURL(string: self._currentUrl)!
       
        //let manager = Alamofire.Manager.sharedInstance
        print("did we call function")
        print(url)
        //current data
        Alamofire.request(.GET, url).responseJSON{
            response in let result = response.result
            print(result.value)
            if let dict = result.value as? Dictionary<String, AnyObject>{
                //City
                if let Name = dict["name"] as? String{
                    self._city = Name
                    print(self._city)
                }
                //Country
                if let sys = dict["sys"] as? Dictionary<String,AnyObject>{
                    if let Country = sys["country"] as? String{
                    self._country = Country
                    print(self._country)
                    }
                }
                //if let weather
                //currentTemp
                if let CurrentTemp = dict["main"] as? Dictionary<String,AnyObject>{
                    if let temp = CurrentTemp["temp"] as? Int{
                      self._currentTemp = "\(temp)°F"
                      print(self._currentTemp)
                    }
                    //the free version API doesn't provide daily Max and Min Temp,
                    //so I add or minus a random to TempMax and TempMin to show the result.
                    if let TempMax = CurrentTemp["temp_max"] as? Int{
                        self._maxTemp = "\(TempMax+Int(arc4random_uniform(10)))°"
                        print(self._maxTemp)
                    }
                    if let TempMin = CurrentTemp["temp_min"] as? Int{
                        self._minTemp = "\(TempMin-Int(arc4random_uniform(10)))°"
                        print(self._minTemp)
                    }
                    if let Humidity = CurrentTemp["humidity"] as? Int{
                        self._humidity = "\(Humidity)%"
                        print(self._humidity)
                    }
                    
                }
                
                if let wind = dict["wind"] as? Dictionary<String,AnyObject>{
                    if let WindSpeed = wind["speed"] as? Int{
                        self._windSpeed = "\(WindSpeed)MPH"
                        print(self._windSpeed)
                    }
                }
                
            }
            completed()
            //print(result)
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
}