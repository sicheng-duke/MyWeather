//
//  Constants.swift
//  MyWeather
//
//  Created by Sicheng Liu on 15/10/25.
//  Copyright © 2015年 liusicheng. All rights reserved.
//

import Foundation


let URL_BASE = "http://api.openweathermap.org/data/2.5/weather?q="
let KEY = "&units=Imperial&appid=264c69bb8bc51fdb4a51bbe7f1f96470"

typealias DownloadComplete = () -> () //creating closure