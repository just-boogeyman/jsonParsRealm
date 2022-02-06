//
//  TableViewCell2.swift
//  jsonParsLesson
//
//  Created by Ярослав Кочкин on 26.01.2022.
//

import UIKit
import SnapKit
import Then

class TableViewCell2: UITableViewCell {
    
    let apiCaller = APICaller()

    // имя персонажа
    let nameLable = UILabel().then() {
        $0.textColor = .white
        $0.text = "Hello"
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.font = UIFont.boldSystemFont(ofSize: $0.font.pointSize)
        $0.numberOfLines = 0
    }
    
    // статус персонажа
    let status = UILabel().then() {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .white
        $0.text = "Hello"
    }
    
    // текст с пояснением локация
    let textLocation = UILabel().then() {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .white
        $0.text = "Last known lokation:"
    }
    
    // текущая локация
    let location = UILabel().then() {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .white
        $0.numberOfLines = 0
    }
    
    // вью для ячейки
    let cellView = UIView().then() {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 10
    }
    
    // индикатур статуса жизни
    let aliveView = UIView().then() {
        $0.backgroundColor = .green
        $0.layer.cornerRadius = 5
    }
    
    // картинка персонажа
    let imageRM = UIImageView()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
        
    }
    
    
    func initCell(item: Persona, index: Int) {
        contentView.backgroundColor = .darkGray

        nameLable.text = item.name
        status.text = "\(item.status) - \(item.species)"
        location.text = item.location.name
 
        
        switch item.status {
        case "Alive":
            aliveView.backgroundColor = .green
        case "Dead":
            aliveView.backgroundColor = .red
        default:
            aliveView.backgroundColor = .white
        }
        
        
        DispatchQueue.global().async {
            
            if let image = self.apiCaller.cacheDataSourse.object(forKey: index as AnyObject) {
                DispatchQueue.main.async {
                    self.imageRM.image = image
                }
            }
            else {
                self.apiCaller.obtainImage(imageUrl: item.image) { [ weak self ] (image) in
                    DispatchQueue.main.async {
                        self?.imageRM.image = image
                        self?.apiCaller.cacheDataSourse.setObject(image!, forKey: index as AnyObject)
                    }
                }
            }
        }
        prepareView()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
        func prepareView() {
            
            self.addSubview(cellView)
            cellView.addSubview(imageRM)
            cellView.addSubview(nameLable)
            cellView.addSubview(aliveView)
            cellView.addSubview(status)
            cellView.addSubview(textLocation)
            cellView.addSubview(location)
            

            
            cellView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview().inset(7)
                make.leading.trailing.equalToSuperview().inset(7)
            }
            
            imageRM.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(0)
                make.leading.equalToSuperview().inset(10)
                make.width.height.equalTo(130)
            }

            nameLable.backgroundColor = UIColor.gray
            nameLable.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(10)
                make.leading.equalTo(imageRM.snp.trailing).offset(10)
                make.trailing.equalToSuperview().inset(10)
            }
            
            aliveView.snp.makeConstraints { make in
                make.leading.equalTo(imageRM.snp.trailing).offset(10)
                make.top.equalTo(nameLable.snp.bottom).offset(15)
                make.width.height.equalTo(10)
            }
            
            status.snp.makeConstraints { make in
                make.leading.equalTo(aliveView.snp.trailing).offset(10)
                make.top.equalTo(nameLable.snp.bottom).offset(10)

            }
            
            textLocation.snp.makeConstraints { make in
                make.leading.equalTo(imageRM.snp.trailing).offset(10)
                make.top.equalTo(status.snp.bottom).offset(15)
            }
            
            location.snp.makeConstraints { make in
                make.leading.equalTo(imageRM.snp.trailing).offset(10)
                make.top.equalTo(textLocation.snp.bottom).offset(0)
                make.trailing.equalToSuperview().inset(10)

            }
            
        }
}
