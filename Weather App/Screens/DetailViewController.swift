//
//  detailViewController.swift
//  Weather App
//
//  Created by Ankur Kothawade on 2/13/23.
//

import UIKit

class detailViewController: UIViewController {
    

    var list: List? 

    @IBOutlet var detailView: UIView!
    @IBOutlet weak var cloudLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var humidityValueLbl: UILabel!
    @IBOutlet weak var pressurLbl: UILabel!
    @IBOutlet weak var pressureValueLbl: UILabel!
    @IBOutlet weak var feelsLikeLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var windSpeedLbl: UILabel!
    @IBOutlet weak var detailImageIcon: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailWeatherConfiguration()
        
        navigationController?.navigationBar.tintColor = .blue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradient2()
        super.viewWillAppear(animated)
    }
    
    func setGradient2() {
        let gradientLayer = CAGradientLayer()

                gradientLayer.frame = view.bounds
                gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1).cgColor]
                gradientLayer.shouldRasterize = true
        self.view.layer.insertSublayer(gradientLayer , at: 0)
        
    }
    

    
    func detailWeatherConfiguration() {
        if let list = list {
            humidityValueLbl.text = "\(list.main.humidity)%"
            print(list.main.pressure)
            pressureValueLbl.text = "\(list.main.pressure) "
            tempLbl.text = "\(list.main.temp)°C"
//            feelsLikeLbl.text = "\(list.weather[0].description)"
            windSpeedLbl.text = "\(list.wind.speed)km/h"
            detailImageIcon.setImage(with: "https://openweathermap.org/img/w/" + list.weather[0].icon + ".png")
            cloudLbl.text = "\(list.clouds.all)%"
        }
        
    }
    
}
    

