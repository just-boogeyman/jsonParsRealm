//
//  APICaller.swift
//  jsonParsLesson
//
//  Created by Ярослав Кочкин on 11.12.2021.
//

import Foundation
import UIKit
import RealmSwift



class APICaller {
    
//    let realm = try! Realm()
//    lazy var categories: Results<Category> = { self.realm.objects(Category.self) }()

    var totalArrey = [Persona]()
 
    var lessons: Lesson? = nil
    var arreyCount: Int = 0
    let urlString = "https://rickandmortyapi.com/api/character"
    var nextStr: String = ""
    
    lazy var cacheDataSourse: NSCache<AnyObject, UIImage> = {
        let cache = NSCache<AnyObject, UIImage>()
        return cache
    }()
    
    func fetchData(urlString: String, completion: @escaping (Result<Lesson, Error>) -> Void) {

        guard let url = URL(string: urlString) else { return }// создаем url структуры экземпляра

        URLSession.shared.dataTask(with: url) { data, responce, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            do {
                let lessons = try JSONDecoder().decode(Lesson.self, from: data)
                    completion(.success(lessons))
            }catch{
                
                print(error)
                
            }
            

        }.resume()
    }
    
    
    func obtainImage(imageUrl: String, completion: @escaping ((UIImage?) -> Void)) {
        
        URLSession.shared.dataTask(with: URL(string: imageUrl)!) { data, responce, error in
            if let error = error {
                print("Error")
            }
            else {
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }.resume()

    }
    
    
}
