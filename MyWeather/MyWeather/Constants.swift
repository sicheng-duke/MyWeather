//
//  Constants.swift
//  MyWeather
//
//  Created by Sicheng Liu on 15/10/25.
//  Copyright © 2015年 liusicheng. All rights reserved.
//

import Foundation


let URL_BASE = "http://api.openweathermap.org/data/2.5/weather?q="
let BASE_KEY = "&units=Imperial&appid=bd82977b86bf27fb59a04b61b657fb6f"
let URL_BASE_FORECAST = "http://api.openweathermap.org/data/2.5/forecast/daily?q="
let URL_FORECAST = "&units=Imperial&cnt=5&appid=bd82977b86bf27fb59a04b61b657fb6f"
typealias DownloadComplete = () -> () //creating closure