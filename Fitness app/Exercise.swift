//
//  Exercise.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-13.
//

import Firebase

struct Exercise {
    let name: String
    let type: String
    let muscle: String
    let difficulty: String
    
    init(snapshot: QueryDocumentSnapshot) {
        let snapshotValue = snapshot.data()
        name = snapshotValue["name"] as! String
        type = snapshotValue["type"] as! String
        muscle = snapshotValue["muscle"] as! String
        difficulty = snapshotValue["difficulty"] as! String
    }
}
