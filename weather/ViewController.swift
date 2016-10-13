//
//  ViewController.swift
//  weather
//
//  Created by 肖文禹 on 16/9/14.
//  Copyright © 2016年 肖文禹. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    let locationManger:CLLocationManager =
        CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        
        if (ios8()) {
            locationManger.requestAlwaysAuthorization()
        }
        locationManger.startUpdatingLocation()
    }
    
    func ios8() -> Bool
    {
        let version = NSString(string: UIDevice.current.systemVersion).floatValue
        
        return version >= 8.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location:CLLocation = locations[locations.count - 1] as! CLLocation
        
        if location.horizontalAccuracy > 0 {
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
            self.updateWeatherInfo(latitude: location.coordinate.latitude,longtitude:location.coordinate.longitude)
            locationManger.stopUpdatingLocation()
        }
    }
    func updateWeatherInfo(latitude:CLLocationDegrees,longtitude:CLLocationDegrees)
    {
        let manager = AFHTTPRequestSerializer()
        let url = "http://api.openweathermap.org/data/2.5/weather"
        let params = ["lat":latitude,"lon":longtitude,"cnt":0]
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print(error)
    }

}

