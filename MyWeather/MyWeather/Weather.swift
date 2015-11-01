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
    
    init(name: String)
    {
        self._city = name
        let url = URL_BASE+self._city+BASE_KEY
        _currentUrl = url
        _forcastUrl = URL_BASE_FORECAST+self._city+URL_FORECAST
        /*
        self._1dayAfter = Weather(name: self._city)
        self._2dayAfter = Weather(name: self._city)
        self._3dayAfter = Weather(name: self._city)
        self._4dayAfter = Weather(name: self._city)
        */
        
        
        
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
    
    
    
    func downloadForecastWeatherDetails(completed: DownloadComplete){
        let url = NSURL(string: self._forcastUrl)!
        
        //let manager = Alamofire.Manager.sharedInstance
        print("did we call function")
        print(url)
        //current data
        
        Alamofire.request(.GET, url).responseJSON{
            response in let result = response.result
            print(result.value)
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let Temp = dict["list"] as? [Dictionary<String,AnyObject>]
                    where Temp.count > 0{
                        if let today = Temp[0]["temp"] as? Dictionary<String,AnyObject>{
                            if let tempMax = today["max"] as? Int{
                                self._maxTemp = "\(tempMax)°"
                                print(self._maxTemp)
                            }
                            if let tempMin = today["min"] as? Int{
                                self._minTemp = "\(tempMin)°"
                                print(self._minTemp)
                            }
                        }
                        
                        self._1dayAfter = Weather(name: self._city)
                        if let oneDay = Temp[1]["temp"] as? Dictionary<String,AnyObject>{
                            if let tempMax = oneDay["max"] as? Int{
                                self.oneDayAfter._maxTemp = "\(tempMax)°"
                                print(self.oneDayAfter._maxTemp)
                            }
                            if let tempMin = oneDay["min"] as? Int{
                                self.oneDayAfter._minTemp = "\(tempMin)°"
                                print(self.oneDayAfter._minTemp)

                            }
                        }
                        
                        
                        self._2dayAfter = Weather(name: self._city)
                        if let today = Temp[2]["temp"] as? Dictionary<String,AnyObject>{
                            if let tempMax = today["max"] as? Int{
                                self.twoDayAfter._maxTemp = "\(tempMax)°"
                                print(self._maxTemp)
                            }
                            if let tempMin = today["min"] as? Int{
                                self.twoDayAfter._minTemp = "\(tempMin)°"
                                print(self.twoDayAfter._minTemp)
                            }
                        }
                        
                        self._3dayAfter = Weather(name: self._city)
                        if let today = Temp[3]["temp"] as? Dictionary<String,AnyObject>{
                            if let tempMax = today["max"] as? Int{
                                self.threeDayAfter._maxTemp = "\(tempMax)°"
                                print(self.threeDayAfter._maxTemp)
                            }
                            if let tempMin = today["min"] as? Int{
                                self.threeDayAfter._minTemp = "\(tempMin)°"
                                print(self.threeDayAfter._minTemp)
                            }
                        }
                        
                        
                        self._4dayAfter = Weather(name: self._city)
                        if let today = Temp[3]["temp"] as? Dictionary<String,AnyObject>{
                            if let tempMax = today["max"] as? Int{
                                self.fourDayAfter._maxTemp = "\(tempMax)°"
                                print(self.fourDayAfter._maxTemp)
                            }
                            if let tempMin = today["min"] as? Int{
                                self.fourDayAfter._minTemp = "\(tempMin)°"
                                print(self.fourDayAfter._minTemp)
                            }
                        }
                        
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                
                

                

            }
        completed()
        
        }
        //print(result)
    }
    
    
    
    
    
    
    
    
    
    
};