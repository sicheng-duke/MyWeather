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
    
    
    let cityWeather: Weather = Weather(name: "Durham")
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
            print("did we get here2")
            self.updateUI();
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
        Time.text = formatter.stringFromDate(date)
        Date.text = weekDay[weekday]
        
    }


}

