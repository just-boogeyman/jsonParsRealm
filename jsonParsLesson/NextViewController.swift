//
//  NextViewController.swift
//  jsonParsLesson
//
//  Created by Ярослав Кочкин on 24.01.2022.
//

import Foundation
import UIKit
import SnapKit
import Then



struct Manager {
    
    static var name = String()
    static var numberImage = Int()
    static var status = String()
    static var speciew = String()
    
}


class NextViewController: UIViewController {
    
    
    let nameLable = UILabel().then() {
        $0.textAlignment = .center
        $0.textColor = .black
    }
    
    let imageRM = UIImageView()
    



    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(nameLable)
        view.addSubview(imageRM)
        prepareView()
        nameLable.text = Manager.name
        imageRM.image = APICaller().cachedDataSourse.object(forKey: Manager.numberImage as AnyObject)
//        imageRM.image


    }

    // настройка textField
    func prepareView() {
        nameLable.backgroundColor = UIColor.gray
        nameLable.text = "Hello!)"
        nameLable.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        
        imageRM.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.equalToSuperview().inset(100)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
    
    
}
