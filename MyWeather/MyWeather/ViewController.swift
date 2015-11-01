//
//  ViewController.swift
//  MyWeather
//
//  Created by Sicheng Liu on 15/10/24.
//  Copyright © 2015年 liusicheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    @IBOutlet var oneDayMax: UILabel!
    @IBOutlet var oneDayMin: UILabel!
    
    @IBOutlet var twoDayDate: UILabel!
    @IBOutlet var twoDayMax: UILabel!
    @IBOutlet var twoDayMin: UILabel!
    
    @IBOutlet var threeDayDate: UILabel!
    @IBOutlet var threeDayMax: UILabel!
    @IBOutlet var threeDayMin: UILabel!
    
    @IBOutlet var fourDayDate: UILabel!
    @IBOutlet var fourDayMax: UILabel!
    @IBOutlet var fourDayMin: UILabel!

    var cityWeather: Weather = Weather(name: "Durham")
    override func viewDidLoad() {
        super.viewDidLoad()
        let tmr:NSTimer = NSTimer.scheduledTimerWithTimeInterval(
            2.0,
            target: self,
            selector: Selector("CurrentTime:"),
            userInfo: nil,
            repeats: true)
        tmr.fire()
        print("did we get here1")
        
        cityWeather.downloadWeatherDetails{ () -> () in
            self.cityWeather.downloadForecastWeatherDetails{ () -> () in
                print("did we get here2")
                self.updateUI();
                
            }

        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateUI(){
        CityName.text = cityWeather.city
        CountryName.text = cityWeather.country
        WeatherType.image = UIImage(named: "Cloudy")
        TempNow.text = cityWeather.currentTemp
        TempMax.text = cityWeather.maxTemp
        TempMin.text = cityWeather.minTemp
        Humidity.text = cityWeather.humidity
        WindSpeed.text = cityWeather.windSpeed
        
        
        
        oneDayMax.text = cityWeather.oneDayAfter.maxTemp
        oneDayMin.text = cityWeather.oneDayAfter.minTemp
        
        twoDayMax.text = cityWeather.twoDayAfter.maxTemp
        twoDayMin.text = cityWeather.twoDayAfter.minTemp

        threeDayMax.text = cityWeather.threeDayAfter.maxTemp
        threeDayMin.text = cityWeather.threeDayAfter.minTemp

        fourDayMax.text = cityWeather.fourDayAfter.maxTemp
        fourDayMin.text = cityWeather.fourDayAfter.minTemp

        
        
        
        
    }
    
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

