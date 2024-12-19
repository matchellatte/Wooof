import SwiftUI

struct GetStartedView: View {
    @State private var navigateToScreen1 = false
    @State private var logoScale: CGFloat = 0.5 // Initial scale for animation

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                // Wooof Logo Image with Animation
                Image("wooof") // Replace with your asset name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .scaleEffect(logoScale) // Apply scaling animation
                    .onAppear {
                        withAnimation(
                            .easeOut(duration: 1.5) // Animation duration and easing
                        ) {
                            logoScale = 1.0 // Scale up to full size
                        }
                    }

                Spacer()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    navigateToScreen1 = true
                }
            }
            .navigationDestination(isPresented: $navigateToScreen1) {
                GetStartedScreen1() // Navigate to GetStartedView1
            }
            .background(Color(UIColor.systemBackground))
            .ignoresSafeArea()
        }
    }
}
