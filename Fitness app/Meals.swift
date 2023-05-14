//
//  Meals.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-14.
//

import Firebase

struct Foods {
    let title: String
    let ingredients: String
    let servings: String
    let instructions: String
    
    init(snapshot: QueryDocumentSnapshot) {
        let snapshotValue = snapshot.data()
        title = snapshotValue["title"] as! String
        ingredients = snapshotValue["ingredients"] as! String
        servings = snapshotValue["servings"] as! String
        instructions = snapshotValue["instructions"] as! String
    }
}
