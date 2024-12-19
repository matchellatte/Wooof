import SwiftUI
import Supabase

struct LoginPage: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var isLoggedIn = false // State to trigger navigation to MainTabView

    var body: some View {
        if isLoggedIn {
            // Navigate to MainTabView
            MainTabView()
        } else {
            VStack(spacing: 30) {
                // Wooof Logo
                Image("wooof")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.top, 50)

                Text("Sign in to your Account")
                    .font(.system(size: 30, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)

                // Email Input
                VStack(alignment: .leading, spacing: 5) {
                    Text("Email")
                        .font(.headline)

                    TextField("Enter your email", text: $email)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                        .cornerRadius(8)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding(.horizontal, 24)

                // Password Input
                VStack(alignment: .leading, spacing: 5) {
                    Text("Password")
                        .font(.headline)

                    HStack {
                        if showPassword {
                            TextField("Enter your password", text: $password)
                        } else {
                            SecureField("Enter your password", text: $password)
                        }

                        Button(action: {
                            showPassword.toggle()
                        }) {
                            Image(systemName: showPassword ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .cornerRadius(8)
                }
                .padding(.horizontal, 24)

                // Login Button
                Button(action: login) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "E1364A"))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                }

                Spacer()

                // Sign Up Navigation
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.gray)

                    NavigationLink(destination: SignupPage()) {
                        Text("Sign Up")
                            .foregroundColor(Color(hex: "E1364A"))
                    }
                }
                .padding(.bottom, 50)
            }
            .background(Color(UIColor.systemBackground))
            .ignoresSafeArea()
            .onTapGesture {
                // Dismiss keyboard when tapped outside
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }

    // MARK: - Login Function
    private func login() {
        Task {
            do {
                // Perform Supabase login
                let session = try await SupabaseConfig.shared.client.auth.signIn(email: email, password: password)
                let user = session.user
                print("User ID: \(user.id.uuidString)")

                // Navigate to MainTabView
                isLoggedIn = true
            } catch {
                print("Login Error: \(error.localizedDescription)")
                // Show an inline error message (optional)
            }
        }
    }
}

#Preview{
    LoginPage()
}
