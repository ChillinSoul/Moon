//
//  Avatar.swift
//  Moon
//
//  Created by Axel Bergiers on 21/04/2024.
//

import SwiftUI

struct Avatar: View {
    var name: String
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 50, height: 50)
            Text(String(name.prefix(1)))
                .font(.title)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    Avatar(name: "AB")
}
