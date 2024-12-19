import SwiftUI

struct GetStartedScreen3: View {
    // Animation states for logo
    @State private var logoOpacity: Double = 0
    @State private var logoScale: CGFloat = 0.5
    @State private var logoRotation: Double = -180 // For rotation effect

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // Logo with scale, fade, and rotation animation
            Image("wooof")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .opacity(logoOpacity)
                
                
                .padding(.bottom, 20)

            Spacer()

            // Main Content (without animation)
            VStack(spacing: 20) {
                // Progress Bar without animation (static)
                HStack(spacing: 8) {
                    ForEach([Color(hex: "E1364A"), Color(hex: "E1364A"), Color(hex: "E1364A")], id: \.self) { color in
                        Rectangle()
                            .fill(color)
                            .frame(width: 60, height: 2)
                    }
                }

                // Title and Subtitle without animation (static)
                VStack(spacing: 8) {
                    Text("Timely Reminders")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(hex: "39434F"))

                    Text("Receive notifications before each cycle starts.")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color(hex: "808B9A"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                }

                VStack(spacing: 16) {
                    // NavigationLink for Finish button to go to LoginPage
                    NavigationLink(destination: LoginPage()) { // No isLoggedIn binding passed
                        Text("Finish")
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
        .onAppear {
            // Trigger logo animations on appear
            withAnimation {
                logoOpacity = 1
                logoScale = 1
                logoRotation = 0
            }
        }
    }
}
