//
//  RandomModel.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-18.
//

import Firebase

struct Exercisess {
    let name: String
    let level: String
    let details: String
    let days: String
    var videoURL: String
    
    init(snapshot: QueryDocumentSnapshot) {
        let snapshotValue = snapshot.data()
        name = snapshotValue["name"] as! String
        level = snapshotValue["level"] as! String
        details = snapshotValue["details"] as! String
        days = snapshotValue["days"] as! String
        videoURL = snapshotValue["videoURL"] as! String
    }
}
