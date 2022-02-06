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
    


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        apiCaller.fetchData(urlString: apiCaller.urlString, completion: { [weak self] result in
            switch result {
            case .success(let lesson):
                self?.apiCaller.lessons = lesson
                self?.apiCaller.nextStr = lesson.info.next
                for value in lesson.results {
                    self?.apiCaller.totalArrey.append(value)
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
        return apiCaller.totalArrey.count
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        Manager.numberImage = indexPath.row
        performSegue(withIdentifier: "nextVC", sender: tableView.cellForRow(at: indexPath))

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){

        guard segue.identifier == "nextVC" else { return }
        guard let nextController = segue.destination as? NextViewController else { return }
        nextController.initNVC(item: apiCaller.totalArrey[Manager.numberImage])


    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath) as! TableViewCell2
        
        Manager.numberCell = indexPath.row

        cell.initCell(item: apiCaller.totalArrey[indexPath.row], index: indexPath.row)

        return cell
    }
}
