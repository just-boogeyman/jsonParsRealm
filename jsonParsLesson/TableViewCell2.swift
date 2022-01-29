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

    
    let nameLable = UILabel().then() {
        $0.textAlignment = .center
        $0.textColor = .black
        $0.text = "Hello"
    }
    
    let imageRM = UIImageView()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addSubview(nameLable)
        prepareView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
        func prepareView() {
            nameLable.backgroundColor = UIColor.gray
            nameLable.text = "Hello!)"
            nameLable.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(10)
                make.centerX.equalToSuperview()
                make.width.equalTo(150)
                make.height.equalTo(40)
            }
            
            imageRM.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(10)
                make.left.equalToSuperview().inset(10)
                make.width.equalTo(100)
                make.height.equalTo(100)
            }
        }

}
