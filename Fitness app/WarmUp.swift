//
//  WarmUp.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-14.
//

import Firebase

struct WarmUp {
    let name: String
    let description: String
    let duration: String
    let repetitions: String
    
    init(snapshot: QueryDocumentSnapshot) {
        let snapshotValue = snapshot.data()
        name = snapshotValue["name"] as! String
        description = snapshotValue["description"] as! String
        duration = snapshotValue["duration"] as! String
        repetitions = snapshotValue["repetitions"] as! String
    }
}

