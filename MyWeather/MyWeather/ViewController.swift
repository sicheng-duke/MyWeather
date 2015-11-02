//
//  ViewController.swift
//  MyWeather
//
//  Created by Sicheng Liu on 15/10/24.
//  Copyright © 2015年 liusicheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    //define some component on the view 
    @IBOutlet var Time: UILabel!
    @IBOutlet var Date: UILabel!
    @IBOutlet var CityName: UILabel!
    @IBOutlet var CountryName: UILabel!
    @IBOutlet var WeatherType: UIImageView!
    @IBOutlet var TempNow: UILabel!
    @IBOutlet var TempMax: UILabel!
    @IBOutlet var TempMin: UILabel!
    @IBOutlet var Humidity: UILabel!
    @IBOutlet var WindSpeed: UILabel!
    
    @IBOutlet var oneDayDate: UILabel!
    @IBOutlet var oneDayIcon: UIImageView!
    @IBOutlet var oneDayMax: UILabel!
    @IBOutlet var oneDayMin: UILabel!
    
    @IBOutlet var twoDayDate: UILabel!
    @IBOutlet var twoDayIcon: UIImageView!
    @IBOutlet var twoDayMax: UILabel!
    @IBOutlet var twoDayMin: UILabel!
    
    @IBOutlet var threeDayDate: UILabel!
    @IBOutlet var threeDayIcon: UIImageView!
    @IBOutlet var threeDayMax: UILabel!
    @IBOutlet var threeDayMin: UILabel!
    
    
    @IBOutlet var fourDayDate: UILabel!
    @IBOutlet var fourDayIcon: UIImageView!
    @IBOutlet var fourDayMax: UILabel!
    @IBOutlet var fourDayMin: UILabel!
    
    
    @IBOutlet weak var searchCity: UISearchBar!
    
    var cityWeather: Weather = Weather(name: "London")
    
    //----------------------------------------------------------------------------------------------------------------------------------------------------------------------
    //load view
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCity.delegate = self
        searchCity.returnKeyType = UIReturnKeyType.Done
        let tmr:NSTimer = NSTimer.scheduledTimerWithTimeInterval(
            2.0,
            target: self,
            selector: Selector("CurrentTime:"),
            userInfo: nil,
            repeats: true)
        tmr.fire()
        self.loadData()

        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //----------------------------------------------------------------------------------------------------------------------------------------------------------------------
    //load data
    func loadData(){
      
        cityWeather.downloadWeatherDetails{ () -> () in
            self.cityWeather.downloadForecastWeatherDetails{ () -> () in
                if self.cityWeather.cityValid == 1{
                    self.updateUI();
                }
                else{
                    self.alertMessage()
                }

            }
        }
        

        
    }
    
    
    //----------------------------------------------------------------------------------------------------------------------------------------------------------------------
    //when face error, show alert
    func alertMessage(){
        let alert = UIAlertView()
        alert.title = "Invalid City"
        alert.message = "Please make sure your city name is valid"
        alert.addButtonWithTitle("Try again")
        alert.show()
    }
    
    
    //----------------------------------------------------------------------------------------------------------------------------------------------------------------------
    //hide keyboard after enter
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
        
    }
    
    //----------------------------------------------------------------------------------------------------------------------------------------------------------------------
    //Search bar controller
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        if searchCity.text == nil || searchCity.text == ""{
            view.endEditing(true)
            loadData()
            
        }
        else{
            var name = cityWeather.city
            let trimCity = searchCity.text!.stringByReplacingOccurrencesOfString(" ", withString: "")
            cityWeather.cityName(trimCity)
            cityWeather.downloadWeatherDetails{ () -> () in
                self.cityWeather.downloadForecastWeatherDetails{ () -> () in
                    if self.cityWeather.cityValid == 1{
                        self.updateUI();
                    }
                    else{
                        self.alertMessage()
                    }
                    
                }
            }

            
            
            
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    //----------------------------------------------------------------------------------------------------------------------------------------------------------------------
    //update UI
    func updateUI(){
        let currentWeather:String = weatherIcon[cityWeather.weatherIcon]!
        CityName.text = cityWeather.city
        CountryName.text = cityWeather.country
        WeatherType.image = UIImage(named: currentWeather)
        TempNow.text = cityWeather.currentTemp+"°F"
        TempMax.text = cityWeather.maxTemp
        TempMin.text = cityWeather.minTemp
        Humidity.text = cityWeather.humidity
        WindSpeed.text = cityWeather.windSpeed
        
        let oneDayWeather:String = weatherIcon[cityWeather.oneDayAfter.weatherIcon]!
        oneDayIcon.image = UIImage(named: oneDayWeather)
        oneDayMax.text = cityWeather.oneDayAfter.maxTemp
        oneDayMin.text = cityWeather.oneDayAfter.minTemp
        
        let twoDayWeather:String = weatherIcon[cityWeather.twoDayAfter.weatherIcon]!
        twoDayIcon.image = UIImage(named: twoDayWeather)
        twoDayMax.text = cityWeather.twoDayAfter.maxTemp
        twoDayMin.text = cityWeather.twoDayAfter.minTemp
        
        let threeDayWeather:String = weatherIcon[cityWeather.threeDayAfter.weatherIcon]!
        threeDayIcon.image = UIImage(named: threeDayWeather)
        threeDayMax.text = cityWeather.threeDayAfter.maxTemp
        threeDayMin.text = cityWeather.threeDayAfter.minTemp

        let fourDayWeather:String = weatherIcon[cityWeather.fourDayAfter.weatherIcon]!
        fourDayIcon.image = UIImage(named: fourDayWeather)
        fourDayMax.text = cityWeather.fourDayAfter.maxTemp
        fourDayMin.text = cityWeather.fourDayAfter.minTemp

        
        
        
        
    }
    
    
    //----------------------------------------------------------------------------------------------------------------------------------------------------------------------
    //show the current date and time
    func CurrentTime(timer:NSTimer){
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        let dateComponent =  calendar.components(NSCalendarUnit.NSWeekdayCalendarUnit, fromDate: date)
        let weekday = dateComponent.weekday
        let weekDay:Dictionary = [1: "Sunday",
            2: "Monday",
            3: "Tuesday",
            4: "Wednesday",
            5: "Thurseday",
            6: "Friday",
            7: "Saturday"]
    
        let weekDayAbbr:Dictionary = [0: "SUN",
            1: "MON",
            2: "TUES",
            3: "WED",
            4: "THUR",
            5: "FRI",
            6: "SAT"]
        
        Time.text = formatter.stringFromDate(date)
        Date.text = weekDay[weekday]
        oneDayDate.text = weekDayAbbr[(weekday)%7]
        twoDayDate.text = weekDayAbbr[(weekday+1)%7]
        threeDayDate.text = weekDayAbbr[(weekday+2)%7]
        fourDayDate.text = weekDayAbbr[(weekday+3)%7]
    }


}

