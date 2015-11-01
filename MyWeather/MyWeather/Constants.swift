//
//  Constants.swift
//  MyWeather
//
//  Created by Sicheng Liu on 15/10/25.
//  Copyright © 2015年 liusicheng. All rights reserved.
//

import Foundation


let URL_BASE = "http://api.openweathermap.org/data/2.5/weather?q="
let KEY = "&units=Imperial&appid=bd82977b86bf27fb59a04b61b657fb6f"
let URL_FORCAST = "&units=Imperial&cnt=5&appid=bd82977b86bf27fb59a04b61b657fb6f"
typealias DownloadComplete = () -> () //creating closure