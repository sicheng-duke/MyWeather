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
    //today's data
    private var _city: String!
    private var _country: String!
    private var _cityValid: Int!
    private var _currentTemp: String!
    private var _maxTemp: String!
    private var _minTemp: String!
    private var _windSpeed: String!
    private var _humidity: String!
    private var _currentUrl : String!
    private var _forcastUrl : String!
    private var _weatherIcon: Int!
    
    //next four days
    private var _1dayAfter: Weather!
    private var _2dayAfter: Weather!
    private var _3dayAfter: Weather!
    private var _4dayAfter: Weather!
    
    var city:String{
            return _city
    }
    
    var country:String{
        return _country
    }
    
    var cityValid:Int{
        return _cityValid
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
    
    var weatherIcon:Int{
        return _weatherIcon
    }
    
    var oneDayAfter: Weather {
        return _1dayAfter
    }
    
    var twoDayAfter: Weather{
        return _2dayAfter
    }
    
    var threeDayAfter: Weather{
        return _3dayAfter
    }
    
    var fourDayAfter: Weather{
        return _4dayAfter
    }
    //----------------------------------------------------------------------------------------------------------------------------------------------------------------------
    //change cityName method
    func cityName(name:String){
        _city = name
        let url = URL_BASE+self._city+BASE_KEY
        _currentUrl = url
        _forcastUrl = URL_BASE_FORECAST+self._city+URL_FORECAST
        
    }
    
    //----------------------------------------------------------------------------------------------------------------------------------------------------------------------
    //initialize
    init(name: String)
    {
        
        self._city = name
        self._cityValid = 1;
        let url = URL_BASE+self._city.stringByReplacingOccurrencesOfString(" ", withString: "")+BASE_KEY

        _currentUrl = url
        _forcastUrl = URL_BASE_FORECAST+self._city.stringByReplacingOccurrencesOfString(" ", withString: "")+URL_FORECAST

        
        
        
    }
    
    
    //----------------------------------------------------------------------------------------------------------------------------------------------------------------------
    //download today's data
    func downloadWeatherDetails(completed: DownloadComplete){
        let url = NSURL(string: self._currentUrl)!
       

        //current data
        Alamofire.request(.GET, url).responseJSON{
            response in let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                //check whether receive the correct message
                if let error = dict["message"] as? String{
                    if error.containsString("Error"){
                        self._cityValid = 0
                    }
                }
                else{
                    self._cityValid = 1
                }
                
                
                //City
                if let Name = dict["name"] as? String{
                    self._city = Name
                   
                }
                
                //Country
                if let sys = dict["sys"] as? Dictionary<String,AnyObject>{
                    if let Country = sys["country"] as? String{
                    self._country = Country
                    
                    }
                }
                
                //currentTemp
                if let CurrentTemp = dict["main"] as? Dictionary<String,AnyObject>{
                    if let temp = CurrentTemp["temp"] as? Int{
                      self._currentTemp = "\(temp)"
              
                    }
                    if let Humidity = CurrentTemp["humidity"] as? Int{
                        self._humidity = "\(Humidity)%"
                       
                    }
                    
                }
                
                //wind
                if let wind = dict["wind"] as? Dictionary<String,AnyObject>{
                    if let WindSpeed = wind["speed"] as? Int{
                        self._windSpeed = "\(WindSpeed)MPH"
                      
                    }
                }
                
                //weather type
                if let weatherInfo = dict["weather"] as? [Dictionary<String,AnyObject>]{
                    if let icon = weatherInfo[0]["id"] as? Int{
                        if icon == 800{
                            self._weatherIcon = icon
                        }
                        else {
                            self._weatherIcon = icon/100
                        }
                        
                        
                    }
                }
                
            }
            completed()
           
        }
        
    }
    
    
    //----------------------------------------------------------------------------------------------------------------------------------------------------------------------
    //download next four days' data
    func downloadForecastWeatherDetails(completed: DownloadComplete){
        let url = NSURL(string: self._forcastUrl)!
        

        //current data
        
        Alamofire.request(.GET, url).responseJSON{
            response in let result = response.result
                if let dict = result.value as? Dictionary<String, AnyObject>{
                if let Temp = dict["list"] as? [Dictionary<String,AnyObject>]
                    where Temp.count > 4{
                        
                        //maximum and minimum temp
                        //today
                        if let today = Temp[0]["temp"] as? Dictionary<String,AnyObject>{
                            if let tempMax = today["max"] as? Int{
                                self._maxTemp = "\(tempMax)°"
                                
                            }
                            if let tempMin = today["min"] as? Int{
                                self._minTemp = "\(tempMin)°"
                               
                            }
                        }
                        
                        //next day
                        self._1dayAfter = Weather(name: self._city)
                        if let oneDay = Temp[1]["temp"] as? Dictionary<String,AnyObject>{
                            if let tempMax = oneDay["max"] as? Int{
                                self._1dayAfter._maxTemp = "\(tempMax)°"
                            
                            }
                            if let tempMin = oneDay["min"] as? Int{
                                self._1dayAfter._minTemp = "\(tempMin)°"
                                
                            }
                            if let weatherInfo = Temp[1]["weather"] as? [Dictionary<String,AnyObject>]{
                                if let icon = weatherInfo[0]["id"] as? Int{

                                    if icon == 800{ self._1dayAfter._weatherIcon = icon}
                                    else {self._1dayAfter._weatherIcon = icon/100}
                                    
                                }
                            }
                        }
                        
                        //2 day
                        self._2dayAfter = Weather(name: self._city)
                        if let twoDay = Temp[2]["temp"] as? Dictionary<String,AnyObject>{
                            if let tempMax = twoDay["max"] as? Int{
                                self._2dayAfter._maxTemp = "\(tempMax)°"
                                
                            }
                            if let tempMin = twoDay["min"] as? Int{
                                self._2dayAfter._minTemp = "\(tempMin)°"
                                
                            }
                            if let weatherInfo = Temp[2]["weather"] as? [Dictionary<String,AnyObject>]{
                                if let icon = weatherInfo[0]["id"] as? Int{
                                    
                                    if icon == 800{ self._2dayAfter._weatherIcon = icon}
                                    else {self._2dayAfter._weatherIcon = icon/100}
                                    
                                }
                            }
                        }
                        
                        //3 day
                        self._3dayAfter = Weather(name: self._city)
                        if let threeDay = Temp[3]["temp"] as? Dictionary<String,AnyObject>{
                            if let tempMax = threeDay["max"] as? Int{
                                self._3dayAfter._maxTemp = "\(tempMax)°"
                                
                            }
                            if let tempMin = threeDay["min"] as? Int{
                                self._3dayAfter._minTemp = "\(tempMin)°"
                                
                            }
                            if let weatherInfo = Temp[3]["weather"] as? [Dictionary<String,AnyObject>]{
                                if let icon = weatherInfo[0]["id"] as? Int{
                                    
                                    if icon == 800{ self._3dayAfter._weatherIcon = icon}
                                    else {self._3dayAfter._weatherIcon = icon/100}
                                    
                                }
                            }
                        }
                        
                        //four day
                        self._4dayAfter = Weather(name: self._city)
                        if let fourDay = Temp[4]["temp"] as? Dictionary<String,AnyObject>{
                            if let tempMax = fourDay["max"] as? Int{
                                self._4dayAfter._maxTemp = "\(tempMax)°"
                                
                            }
                            
                            if let tempMin = fourDay["min"] as? Int{
                                self._4dayAfter._minTemp = "\(tempMin)°"
                                
                            }
                            
                            if let weatherInfo = Temp[4]["weather"] as? [Dictionary<String,AnyObject>]{
                                if let icon = weatherInfo[0]["id"] as? Int{
                                  
                                    if icon == 800{ self._4dayAfter._weatherIcon = icon}
                                    else {self._4dayAfter._weatherIcon = icon/100}
                                                                    }
                            }
                            
                            
                        }
                       
                        
                    }

            }
        completed()
        
        }
        
    }
    
    
    
    
    
    
    
    
    
    
};