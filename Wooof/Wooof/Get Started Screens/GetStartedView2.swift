import SwiftUI

struct GetStartedScreen2: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // Logo without animation
            Image("wooof")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .padding(.bottom, 20)

            Spacer()

            // Main Content with a container and progress bar
            VStack(spacing: 20) {
                // Progress Bar
                HStack(spacing: 8) {
                    ForEach([Color(hex: "E1364A"), Color(hex: "E1364A"), Color(hex: "D9DFE6")], id: \.self) { color in
                        Rectangle()
                            .fill(color)
                            .frame(width: 60, height: 2)
                    }
                }

                // Title and Subtitle
                VStack(spacing: 8) {
                    Text("Personalized Profiles")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(hex: "39434F"))

                    Text("Create profiles for each dog to track cycles individually.")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color(hex: "808B9A"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                }

                VStack(spacing: 16) {
                    // Navigation Link to GetStartedScreen3
                    NavigationLink(destination: GetStartedScreen3()) {
                        Text("Next")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 54)
                            .background(Color(hex: "E1364A"))
                            .cornerRadius(12)
                            .padding(.horizontal, 20)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 400)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .fill(.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    .edgesIgnoringSafeArea(.bottom)
            )
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(false) // Show the back button
    }
}



