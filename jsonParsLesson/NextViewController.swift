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
    static var numberCell = Int()
    static var status = String()
    static var speciew = String()
    
}


class NextViewController: UIViewController, UIScrollViewDelegate {
    
    
    private let apiCaller = APICaller()

    
    let nameLable = UILabel().then() {
        $0.textColor = .white
        $0.text = "Hello"
        $0.font = UIFont.systemFont(ofSize: 22)
        $0.font = UIFont.boldSystemFont(ofSize: $0.font.pointSize)
        $0.numberOfLines = 0
    }
    
    let liveStatus = UILabel().then() {
        $0.textColor = .white
        $0.text = "Live status:"
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    let speciesText = UILabel().then() {
        $0.textColor = .white
        $0.text = "Species and gender:"
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    let status = UILabel().then() {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: $0.font.pointSize)
    }
    
    let species = UILabel().then() {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: $0.font.pointSize)
    }
    
    let nextScrillView = UIScrollView().then() {
        $0.backgroundColor = .white
//        $0.layer.cornerRadius = 20
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsVerticalScrollIndicator = true
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = true
    }
    
    let nextView = UIView().then() {
        $0.backgroundColor = .gray
        $0.translatesAutoresizingMaskIntoConstraints = false

        $0.layer.cornerRadius = 20
    }
    
    let aliveView = UIView().then() {
        $0.backgroundColor = .green
        $0.layer.cornerRadius = 5
    }
    
    let imageRM = UIImageView()
    



    override func viewDidLoad() {
        super.viewDidLoad()
        


    }
    
    
    func initNVC(item: Persona) {
        
        self.apiCaller.obtainImage(imageUrl: item.image) { [weak self] (image) in
            DispatchQueue.main.async {
                self?.imageRM.image = image
            }
        }
        switch item.status {
        case "Alive":
            aliveView.backgroundColor = .green
        case "Dead":
            aliveView.backgroundColor = .red
        default:
            aliveView.backgroundColor = .white
        }
        nameLable.text = item.name
        status.text = item.status
        species.text = item.species
        prepareView()
        
    }

    // настройка экрана
    func prepareView() {
        
        nextScrillView.addSubview(nextView)
        nextView.addSubview(imageRM)
        nextView.addSubview(nameLable)
        nextView.addSubview(liveStatus)
        nextView.addSubview(aliveView)
        nextView.addSubview(status)
        nextView.addSubview(speciesText)
        nextView.addSubview(species)
        view.addSubview(nextScrillView)
        nextScrillView.contentSize.height = 2000

        
        
        nextScrillView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        nextView.snp.makeConstraints { make in
            make.edges.equalToSuperview()

            make.top.equalToSuperview().inset(50)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(2000)
        }
        
        imageRM.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(300)
        }
        
        nameLable.snp.makeConstraints { make in
            make.top.equalTo(imageRM.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
        }
        
        liveStatus.snp.makeConstraints { make in
            make.top.equalTo(nameLable.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(20)
        }
        aliveView.snp.makeConstraints { make in
            make.top.equalTo(liveStatus.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(10)
        }
        status.snp.makeConstraints { make in
            make.top.equalTo(liveStatus.snp.bottom).offset(5)
            make.leading.equalTo(aliveView.snp.trailing).offset(10)
        }
        speciesText.snp.makeConstraints { make in
            make.top.equalTo(status.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(20)
        }
        species.snp.makeConstraints { make in
            make.top.equalTo(speciesText.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
        }
        
    }
    
    
}
