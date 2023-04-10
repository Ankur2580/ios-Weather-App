//
//  DayViewController.swift
//  Weather App
//
//  Created by Ankur Kothawade on 3/1/23.
//

import UIKit

class DayViewController: UIViewController {
    
    var viewModel1 = WeatherViewModel()
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("json string", viewModel1.weather?.list[0].dt_txt)
        disableDates()
    }
    
}


extension DayViewController {
    func convertDate(currentDate : String) -> String{
        let date = getdate(currentDate: currentDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        let showDate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd-mm-yyyy"
        let resultString = dateFormatter.string(from: showDate!)
        print("ResultString----" , resultString)
        return resultString
        
    }
    
    func getdate(currentDate : String) -> String {
        var newString : String
        let str = currentDate
        let start = str.index(str.startIndex, offsetBy: 0)
        let end = str.index(str.startIndex, offsetBy: 10)
        let range = start...end
        newString = String(str[range])
//        print("Newstring--------" , newString)
        return newString
    }

    func disableDates() {
        
        let dateFormatter = DateFormatter()
        let calendar = Calendar(identifier: .indian)
        var components = DateComponents()
        
        components.month = 0
        components.day = 0
        
        let minDate = calendar.date(byAdding: components, to: Date())
        
        components.month = 0
        components.day = 4
        let maxDate = calendar.date(byAdding: components, to: Date())
        
    
        
        datePicker.maximumDate = maxDate
        datePicker.minimumDate = minDate
    
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    @objc private func dateChanged() {
        presentedViewController?.dismiss(animated: true, completion: nil)
        
        let dateFormater: DateFormatter = DateFormatter()
        dateFormater.dateFormat = "dd-MM-yyyy"
        let stringFromDate: String = dateFormater.string(from: self.datePicker.date)
        print("Stringfromdate---------",stringFromDate)
        print("check string",stringFromDate == convertDate(currentDate: (viewModel1.weather?.list.first?.dt_txt) ?? "" ))
        
    }
}
