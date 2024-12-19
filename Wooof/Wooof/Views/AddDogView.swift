//
//  AddDogView.swift
//  Wooof
//
//  Created by STUDENT on 12/18/24.
//

import Foundation
import SwiftUI

struct AddDogView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @State private var name: String = ""
    @State private var breed: String = ""
    @State private var age: Int?

    var body: some View {
        Form {
            TextField("Dog's Name", text: $name)
            TextField("Breed", text: $breed)
            TextField("Age", value: $age, format: .number)

            Button("Save") {
                if let age = age {
                    let dog = Dog(name: name, breed: breed, age: age)
                    modelContext.insert(dog)
                    dismiss()
                }
            }
        }
        .navigationTitle("Add Dog")
    }
}
