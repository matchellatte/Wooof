import SwiftUI
import Supabase

struct SignupPage: View {
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showPassword = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Register")
                    .font(.largeTitle)
                    .bold()
                
                Text("Create an account to continue")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 50)
            
            // Email Input Field
            Group {
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                // Full Name Input Field
                TextField("Full Name", text: $fullName)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .autocapitalization(.words)
            }
            .padding(.horizontal)
            
            // Password Input Field
            HStack {
                if showPassword {
                    TextField("Password", text: $password)
                } else {
                    SecureField("Password", text: $password)
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
            .cornerRadius(8)
            .padding(.horizontal)
            
            // Confirm Password Input Field
            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            
            // Signup Button
            Button(action: signup) {
                Text("Register")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "E1364A"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Notification"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            
            Spacer()
            
            // Navigation to Login Page
            NavigationLink(destination: LoginPage()) {
                Text("Already have an account? Login")
                    .foregroundColor(Color(hex: "E1364A"))
            }

            .padding(.bottom, 20)
        }
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
        .padding()
    }
    
    private func signup() {
        // Ensure passwords match
        guard password == confirmPassword else {
            alertMessage = "Passwords do not match."
            showAlert = true
            return
        }
        
        Task {
            do {
                // Step 1: Sign up with Supabase Auth
                let authResponse = try await SupabaseConfig.shared.client.auth.signUp(email: email, password: password)
                
                // Ensure the user object is valid
                let userID = authResponse.user.id // No optional chaining needed
                
                // Step 2: Insert the user into the "users" table
                _ = try SupabaseConfig.shared.client
                    .from("users") // Ensure the table name matches exactly
                    .insert([
                        "id": userID.uuidString, // Convert UUID to String
                        "email": email,
                        "full_name": fullName
                    ])
                    .select() // Ensures the response is fetched
                
                // You can handle the userInsertResponse here if needed (e.g., check for a success response)
                alertMessage = "Signup successful! Please check your email for verification."
            } catch {
                // Handle errors during signup or insertion
                alertMessage = "Signup failed: \(error.localizedDescription)"
            }
            showAlert = true
        }
    }





}


struct SignupPage_Previews: PreviewProvider {
    static var previews: some View {
        SignupPage()
            .preferredColorScheme(.light) // Preview in light mode
            .previewDevice("iPhone 12")
        
        SignupPage()
            .preferredColorScheme(.dark) // Preview in dark mode
            .previewDevice("iPhone 12")
    }
}
