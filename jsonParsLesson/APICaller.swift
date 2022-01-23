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
    
    let realm = try! Realm()
    lazy var categories: Results<Category> = { self.realm.objects(Category.self) }()
    
    var nameArrey = [String]()
    var imageArray = [String]()

   
    
    lazy var cachedDataSourse: NSCache<AnyObject, UIImage> = {
        let cache = NSCache <AnyObject, UIImage>()
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
    
    func obtainImage(urlImage: String, completion: @escaping ((UIImage?) -> Void)) {

        let url = URL(string: urlImage)

        URLSession.shared.dataTask(with: url!) { data, responce, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            else {

                let image = UIImage(data: data!)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }.resume()

    }
    
    // обновление кэша
    func upDateCache(images: [String]) {
        for (index, urlImage) in images.enumerated() {
//            print(image)
            obtainImage(urlImage: urlImage) { [weak self] (image) in
                if let image = image {
                    self?.cachedDataSourse.setObject(image, forKey: index as AnyObject)
                } else {
                    return print("error")
                }
            }
        }
    }
    
    
    func addArray () {
        
        if nameArrey.count != 0 {
            
            try! realm.write() { // 2
                for (index, _) in nameArrey.enumerated() { // 4
                    let newCategory = Category()
                    newCategory.name = nameArrey[index]
                    newCategory.image = imageArray[index]
                    realm.add(newCategory)
             }
           }
            categories = realm.objects(Category.self) // 5
        } else {
            if categories.count != 0 {
                try! realm.write() { // 2
                    for category in categories { // 4
                        nameArrey.append(category.name)
                        imageArray.append(category.image)
                    }
                }
            }
        }
    }
    
    
}
