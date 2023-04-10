//
//  FiveDayViewController.swift
//  Weather App
//
//  Created by Ankur Kothawade on 2/8/23.
//

import UIKit



class FiveDayViewController: UIViewController {
    
    var listArray : [Welcome] =  []
    var originalWeatherList:[List] = []
    
    @IBOutlet weak var datePickerNib: UIDatePicker!
    
    @IBOutlet weak var cityLbl: UILabel!
    
    @IBOutlet weak var cityText: UITextField!
    
    @IBOutlet weak var weatherTableView: UITableView!
    
    @IBAction func searchBtnAction(_ sender: Any) {
        print("City---" , cityText.text ?? "")
        cityLbl.text = cityText.text
//        dateChanged()
        
        initViewModel()
        getSelectedDateDetails()
        
    }
    
    func getSelectedDateDetails() {
        let dateFormater: DateFormatter = DateFormatter()
        let selectedDate: String = dateFormater.string(from: datePickerNib.date)
        print("Selected date---------",selectedDate)
        
        print("Helklloe")
        
    }
    
    var viewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        weatherTableView.delegate = self
        weatherTableView.dataSource = self

//        self.view.addSubview(bgView)
//        weatherTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        self.view.addSubview(weatherTableView)
//        weatherTableView.backgroundColor = .clear
        
        
        
//        NSLayoutConstraint.activate([
//            weatherTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
//            weatherTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            weatherTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            weatherTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])

       
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
    
}

extension FiveDayViewController {
    func configuration() {
        weatherTableView.register(UINib(nibName: "FiveDayWeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "FiveDayWeatherTableViewCell")
        initViewModel()
        observeEvent()
        disableDates()
        
        
    }
    
    func initViewModel() {
        viewModel.fetchWeather(city: "Pune")
        viewModel.fetchWeather(city: cityText.text ?? "")
//        weatherTableView.reloadData()
    }
    
    func observeEvent() {
        viewModel.eventHandler = { event in
//            guard let self else {return}
            switch event{
            case .loading :
                print("Data Loading...")
            case .stopLoading :
                print("Stop Loading....")
            case .dataLoaded:
//                print(self.viewModel.weather as Any)
                DispatchQueue.main.async {
                    self.originalWeatherList = self.viewModel.weather?.list ?? []
                    self.weatherTableView.reloadData()
                }
                print("Data Loaded")
            case .error(let error1):
                print(error1)
            }
        }
    }
}


extension FiveDayViewController : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weather?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FiveDayWeatherTableViewCell") as? FiveDayWeatherTableViewCell else {
            return UITableViewCell()
        }
        let weather = viewModel.weather?.list[indexPath.row]
        cell.list = weather
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detail : detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! detailViewController
        let detailWeather = viewModel.weather?.list[indexPath.row]
        detail.list = detailWeather
        
        self.navigationController?.pushViewController(detail, animated: true)
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
        
    
        
        datePickerNib.maximumDate = maxDate
        datePickerNib.minimumDate = minDate
    
        datePickerNib.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
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
    
    @objc private func dateChanged() {
        presentedViewController?.dismiss(animated: true, completion: nil)
        let dateFormater: DateFormatter = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let stringFromDate: String = dateFormater.string(from: self.datePickerNib.date)
        print("Stringfromdate---------",stringFromDate)
        
        viewModel.weather?.list = originalWeatherList

        let listArray = viewModel.weather?.list.filter({
            listData in getdate(currentDate: listData.dt_txt).contains(stringFromDate)
        })
        
        viewModel.weather?.list = listArray!
        self.weatherTableView.reloadData()
        
    }
    
}
