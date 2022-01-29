//
//  ViewController.swift
//  jsonParsLesson
//
//  Created by Ярослав Кочкин on 11.12.2021.
//

import UIKit
import SnapKit
import Then



class ViewController: UIViewController {
    
    private let apiCaller = APICaller()
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(TableViewCell2.self, forCellReuseIdentifier: "idCell")
        return tableView
    }()
    
    private var totalArrey = [Persona]()
 
    var lessons: Lesson? = nil
    var arreyCount: Int = 0
    let urlString = "https://rickandmortyapi.com/api/character"
    var nextStr: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        apiCaller.fetchData(urlString: urlString, completion: { [weak self] result in
            switch result {
            case .success(let lesson):
                self?.lessons = lesson
                self?.nextStr = lesson.info.next
                for value in lesson.results {
                    self?.apiCaller.nameArrey.append(value.name)
                    self?.apiCaller.imageArray.append(value.image)
                }
                
                DispatchQueue.main.async {
                    self?.apiCaller.addArray()
                    self?.apiCaller.upDateCache(images: self!.apiCaller.imageArray)
                }
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                break
            }
        })
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.apiCaller.nameArrey.count
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Manager.name = apiCaller.nameArrey[indexPath.row]
        Manager.status = ""
        Manager.numberImage = indexPath.row
        performSegue(withIdentifier: "nextVC", sender: tableView.cellForRow(at: indexPath))    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath) as! TableViewCell2
        
        if indexPath.row == self.apiCaller.nameArrey.count-1 {
            apiCaller.fetchData(urlString: nextStr, completion: { [weak self] result in
                switch result {
                case .success(let lesson):
                    self?.lessons = lesson
                    self?.nextStr = lesson.info.next
                    for value in lesson.results {
                        self?.apiCaller.nameArrey.append(value.name)
                        self?.apiCaller.imageArray.append(value.image)
                    }
                    DispatchQueue.main.async {
                        self?.apiCaller.addArray()
                        self?.apiCaller.upDateCache(images: self!.apiCaller.imageArray)
                    }
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(_):
                    break
                }
            })
        }

        cell.nameLable.text = "wqe"
        cell.imageRM.image = self.apiCaller.cachedDataSourse.object(forKey: indexPath.row as AnyObject)
//        cell.textLabel?.text = self.apiCaller.nameArrey[indexPath.row]
//        cell.imageView?.image = self.apiCaller.cachedDataSourse.object(forKey: indexPath.row as AnyObject)

        return cell
    }
}
