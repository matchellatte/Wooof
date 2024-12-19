import SwiftUI

struct GetStartedScreen1: View {
    @State private var isLoggedIn: Bool = false // Track login status

    var body: some View {
        ZStack {
            Color(white: 0.98).edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                Spacer()

                // Logo at the top
                Image("wooof") // Replace with your logo asset name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300) // Adjust size as needed
                    .padding(.bottom, 20)

                // Content
                VStack(spacing: 20) {
                    // Progress Bar
                    HStack(spacing: 8) {
                        ForEach([Color(hex: "E1364A"), Color(hex: "D9DFE6"), Color(hex: "D9DFE6")], id: \.self) { color in
                            Rectangle()
                                .fill(color)
                                .frame(width: 60, height: 2)
                        }
                    }

                    // Title and Subtitle
                    VStack(spacing: 8) {
                        Text("Track Your Dog's Cycle")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color(hex: "39434F"))

                        Text("Stay on top of your dog’s health with easy cycle tracking and reminders.")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color(hex: "808B9A"))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                    }

                    VStack(spacing: 16) {
                        // Navigation Link to GetStartedScreen2
                        NavigationLink(destination: GetStartedScreen2()) {
                            Text("Get Started")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, minHeight: 54)
                                .background(Color(hex: "E1364A"))
                                .cornerRadius(12)
                                .padding(.horizontal, 20)
                        }

                        // Login Button
                        NavigationLink(destination: LoginPage()) {
                            Text("Log in")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color(hex: "A0AEC0"))
                        }

                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 400)
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .fill(.white)
                        .edgesIgnoringSafeArea(.bottom)
                )
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true) // Hide navigation bar
    }
}

// MARK: - PreviewProvider

struct GetStartedScreen1_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedScreen1()
            .previewDevice("iPhone 12")
            .preferredColorScheme(.light)
    }
}
