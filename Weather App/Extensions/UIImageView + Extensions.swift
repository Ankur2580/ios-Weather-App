//
//  UIImageView + Extensions.swift
//  Weather App
//
//  Created by Ankur Kothawade on 2/15/23.
//

import Kingfisher
import UIKit

extension UIImageView {
    func setImage(with urlString: String){
        guard let url = URL.init(string: urlString) else{
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}

