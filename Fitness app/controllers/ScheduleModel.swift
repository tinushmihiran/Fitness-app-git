//
//  ScheduleModel.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-20.
//

//import Firebase
//
//struct Schedule {
//    let name: String
//    let description: String
//    let muscle: String
//    let days: String
//
//
//    init(snapshot: QueryDocumentSnapshot) {
//        let snapshotValue = snapshot.data()
//        name = snapshotValue["name"] as! String
//        description = snapshotValue["description"] as! String
//        muscle = snapshotValue["muscle"] as! String
//        days = snapshotValue["days"] as! String
//
//    }
//}

import Firebase

struct Schedule {
    let name: String
    let description: String
    let muscle: String
    let days: String

    init(snapshot: QueryDocumentSnapshot) {
        let snapshotValue = snapshot.data()

        if let name = snapshotValue["name"] as? String {
            self.name = name
        } else {
            self.name = ""
        }

        if let description = snapshotValue["description"] as? String {
            self.description = description
        } else {
            self.description = ""
        }

        if let muscle = snapshotValue["muscle"] as? String {
            self.muscle = muscle
        } else {
            self.muscle = ""
        }

        if let days = snapshotValue["days"] as? String {
            self.days = days
        } else {
            self.days = ""
        }
    }
}

