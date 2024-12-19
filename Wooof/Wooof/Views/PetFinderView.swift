import SwiftUI
import Combine

struct PetFinderView: View {
    @StateObject private var viewModel = PetFinderViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // MARK: - Introduction Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Adopt a Pet")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)

                    Text("These pets are looking for a loving home. Browse through the list of pets available for adoption and click the link to visit Petfinder for more details.")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)

                    Link("Visit Petfinder", destination: URL(string: "https://www.petfinder.com/")!)
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.vertical, 4)
                }
                .padding()
                .background(Color(UIColor.secondarySystemGroupedBackground))
                .cornerRadius(12)
                .padding(.horizontal)
           

                // MARK: - Content Section
                if viewModel.isLoading {
                    ProgressView("Fetching Pets...")
                        .padding()
                        .scaleEffect(1.2)
                        .foregroundColor(.gray)
                } else if let errorMessage = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Text("Oops! Something went wrong.")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.red)
                        Text(errorMessage)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        Button(action: {
                            viewModel.fetchPets()
                        }) {
                            Text("Try Again")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.pets) { pet in
                                PetFinderCardView(pet: pet)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("Find Your Pet")
            .onAppear {
                viewModel.fetchPets()
            }
        }
    }
}

struct PetFinderCardView: View {
    let pet: Pet

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageURL = pet.imageURL, let url = URL(string: imageURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 150)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .foregroundColor(.gray)
            }

            Text(pet.name)
                .font(.headline)
                .foregroundColor(.primary)

            Text(pet.breed)
                .font(.subheadline)
                .foregroundColor(.secondary)

            if let description = pet.description {
                Text(description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(3)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
