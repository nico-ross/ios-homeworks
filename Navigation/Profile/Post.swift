//
//  Post.swift
//  Navigation
//
//  Created by n p on 24.04.2023.
//

import Foundation

struct Post {
    let author: String
    let description: String
    let image: String
    var likes: Int
    var views: Int
    var isLiked: Bool = false
}

extension Post {
    static func make() -> [Post] {
        [
            Post(author: "@zuck", description: "Excited to finally show you all the new Meta Quest Pro we've been working on!", image: "zuck", likes: 450, views: 5_989),
            Post(author: "@elonmusk", description: "Elon Reeve Musk is a business magnate and investor", image: "elon", likes: 790, views: 10_887),
            Post(author: "@tim_cook", description: "Tim Apple with President", image: "tim", likes: 128, views: 3_812),
            Post(author: "@jeffbezos", description: "My first job. Still the same great burger! Happy Sunday!", image: "jeff", likes: 333, views: 12_691)
        ]
    }
}
