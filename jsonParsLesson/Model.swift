//
//  Model.swift
//  jsonParsLesson
//
//  Created by Ярослав Кочкин on 11.12.2021.
//

import Foundation


struct Lesson: Decodable{
    
    var info: Info
    var results: [Persona]
    
    
}


struct Persona: Decodable {
    var name: String
    var status: String
    var image: String
    var species: String
}



struct Info: Decodable {
    var next: String
}

