import SwiftUI

struct PetCardView: View {
    let dog: Dog

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(dog.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text(dog.breed)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }

            Spacer()

            Image("dog_profile_picture") // Placeholder for profile image
                .resizable()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.pink, Color.pink.opacity(0.7)]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}
