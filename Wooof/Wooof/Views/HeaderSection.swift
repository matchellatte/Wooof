//
//  HeaderSection.swift
//  Wooof
//
//  Created by STUDENT on 12/18/24.
//

import Foundation
import SwiftUI

struct HeaderSection: View {
    let dogs: [Dog]
    @Binding var selectedDog: Dog?

    var body: some View {
        HStack {
            Menu {
                ForEach(dogs) { dog in
                    Button(action: { selectedDog = dog }) {
                        Label(dog.name, systemImage: "pawprint.fill")
                    }
                }
            } label: {
                HStack {
                    Text("Active Profiles: \(selectedDog?.name ?? "Select a Pet")")
                        .font(.title3)
                        .fontWeight(.medium)
                    Image(systemName: "chevron.down")
                }
            }

            Spacer()
            Image(systemName: "bell.fill")
                .font(.title2)
                .foregroundColor(.pink)
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}
