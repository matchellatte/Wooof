//
//  EmptyStateView.swift
//  Wooof
//
//  Created by STUDENT on 12/18/24.
//

import Foundation
import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "pawprint.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray)
            
            Text("No pets available")
                .font(.headline)
                .foregroundColor(.gray)
        }
        .padding()
    }
}
