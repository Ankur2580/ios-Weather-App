//
//  FiveDayWeatherTableViewCell.swift
//  Weather App
//
//  Created by Ankur Kothawade on 2/9/23.
//

import UIKit


class FiveDayWeatherTableViewCell: UITableViewCell {
    
    
    var list: List? {
        didSet {
            weatherConfiguration()
        }
    }
    
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var minTempLbl: UILabel!
    @IBOutlet weak var minTempValueLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var maxTempvalueLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func weatherConfiguration() {
        if let list = list {
            minTempValueLbl.text = "\(list.main.temp_min)°C"
            maxTempvalueLbl.text = "\(list.main.temp_max)°C"
            imageIcon.setImage(with: "https://openweathermap.org/img/w/" + list.weather[0].icon + ".png")
            dateLbl.text = convertDate(currentDate : list.dt_txt)
//            dayLbl.text = "\(getCurrentDay())"
            timeLbl.text = gettime(currentTime : list.dt_txt)
//            stringtoDate()
//            convertDateFormat(inputDate: "18-02-2023")
            dayLbl.text = stringtoday(completeString: list.dt_txt)
        }
    }
    
    func convertDate(currentDate : String) -> String{
        let date = getdate(currentDate: currentDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        let showDate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd-mm-yyyy"
        let resultString = dateFormatter.string(from: showDate!)
//        print("ResultString----" , resultString)
        return resultString
        
    }
    
    func gettime(currentTime : String) -> String {
        var newString : String
        let str = currentTime
        let start = str.index(str.startIndex, offsetBy: 12)
        let end = str.index(str.startIndex, offsetBy: 15)
        let range = start...end
        newString = String(str[range])
//        print("Newtime--------" , newString)
        return newString
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

    
    func stringtoDate(){
        let strDate = convertDate(currentDate: list!.dt_txt)
        print("Strdate-------" , strDate)
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd-mm-yyyy"
        dateFormatter.dateFormat = "EEEE"
        let date = dateFormatter.date(from: strDate)
        print(date)
        print(type(of: date))
    }
    
    func getCurrentDay(currentInput : Date) -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfTheWeekString = dateFormatter.string(from: date)
        return dayOfTheWeekString
    }
    

    
    func stringtoday(completeString : String) -> String {
        let dateString = convertDate(currentDate: completeString)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.date(from: dateString)!
        
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "EEEE"
        let day = convertDateFormatter.string(from: date)
        
        return day

    }

    
}


extension FiveDayWeatherTableViewCell {
    override open var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 10
            frame.origin.x += 10
            frame.size.height -= 15
            frame.size.width -= 2 * 10
            super.frame = frame
        }
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 50
        layer.masksToBounds = false

    }
}
