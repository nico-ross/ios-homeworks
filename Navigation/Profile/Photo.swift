//
//  Photo.swift
//  Navigation
//
//  Created by n p on 30.04.2023.
//

import Foundation

struct Photo {
    let image: String
}

extension Photo {
    static func make() -> [Photo] {
        var array = [Photo]()
        for photo in 1...20 {
            array.append(Photo(image: "photo-\(photo)"))
        }
        
        return array
    }
}
