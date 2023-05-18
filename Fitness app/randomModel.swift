//
//  randomModel.swift
//  Fitness app
//
//  Created by Tinush mihiran on 2023-05-18.
//
import FirebaseFirestore
struct Exercisess {
    let id: String
    let name: String
    // Add other properties as needed

    init?(document: QueryDocumentSnapshot) {
        guard let data = document.data() as? [String: Any],
              let name = data["name"] as? String
              // Add other required properties
        else {
            return nil
        }

        self.id = document.documentID
        self.name = name
        // Assign other properties
    }
}
