import SwiftUI

struct DogEstrousCycleView: View {
    var body: some View {
        ZStack(alignment: .top) {
            // Scrollable Content
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Spacer().frame(height: 60) // For sticky header

                    // Image Section
                    Image("hello") // Replace with your asset name
                        .resizable()
                        .scaledToFit()
                        .frame(height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.horizontal)

                    // Estrous Cycle Stages
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "Stages of the Estrous Cycle")
                        
                        ForEach(stageData, id: \.title) { stage in
                            InfoCard(title: stage.title, description: stage.description)
                                .frame(minHeight: 120) // Ensures all cards are the same height
                        }
                    }
                    .padding(.horizontal)

                    // Tips Section
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "Tips for Managing")
                        VStack(spacing: 12) {
                            TipItem(iconName: "pawprint", tip: "Keep your dog on a leash when outside during the estrus stage.")
                            TipItem(iconName: "cross.circle", tip: "Consider spaying your dog if you do not plan to breed.")
                            TipItem(iconName: "heart.fill", tip: "Monitor swelling and discharge to identify each stage.")
                        }
                        .padding()
                        .background(Color(red: 0.98, green: 0.96, blue: 0.95)) // Light beige background
                        .cornerRadius(15)
                    }
                    .padding(.horizontal)

                    // Signs to Watch Section
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "Signs to Watch For")
                        VStack(spacing: 12) {
                            TipItem(iconName: "eye", tip: "Swelling of the vulva and bloody discharge.")
                            TipItem(iconName: "chart.bar.fill", tip: "Increased attention from male dogs.")
                            TipItem(iconName: "thermometer", tip: "Changes in behavior like restlessness or clinginess.")
                        }
                    }
                    .padding(.horizontal)

                    // FAQ Section
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "Frequently Asked Questions")
                        FAQCard(question: "What is the estrous cycle?", answer: "The estrous cycle is a recurring period during which a female dog becomes receptive to mating.")
                        FAQCard(question: "How often does it occur?", answer: "Typically, female dogs go into heat twice a year, but it can vary by breed and age.")
                    }
                    .padding(.horizontal)
                    
                    // Veterinary Clinics Nearby Section
                                        VStack(alignment: .leading, spacing: 12) {
                                            SectionHeader(title: "Veterinary Clinics Nearby")
                                            Text("Find the nearest veterinary clinics in your area for your dog's needs.")
                                                .font(.body)
                                                .foregroundColor(.gray)

                                            NavigationLink(destination: VeterinaryClinicMapView()) {
                                                Text("View on Map")
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                                    .frame(maxWidth: .infinity)
                                                    .padding()
                                                    .background(Color(red: 0.9, green: 0.2, blue: 0.3)) // Button color
                                                    .cornerRadius(15)
                                            }
                                        }
                                        .padding(.horizontal)
                    // PetFinder Section
                                        VStack(alignment: .leading, spacing: 12) {
                                            SectionHeader(title: "Adopt a Pet with PetFinder")
                                            Text("Explore available pets for adoption near you through PetFinder.")
                                                .font(.body)
                                                .foregroundColor(.gray)

                                            NavigationLink(destination: PetFinderView()) {
                                                Text("Browse Pets")
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                                    .frame(maxWidth: .infinity)
                                                    .padding()
                                                    .background(Color.blue) // Button color
                                                    .cornerRadius(15)
                                            }
                                        }
                                        .padding(.horizontal)
                }
                .padding(.bottom, 20)
            }
            
            

            // Sticky Header
            VStack {
                HStack {
                    Text("Dog Estrous Cycle")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(red: 0.9, green: 0.2, blue: 0.3))
                    Spacer()
                }
                .padding()
                .background(Color.white.opacity(0.95))
            }
            .frame(maxWidth: .infinity)
            .zIndex(1) // Ensures header stays on top
        }
        .background(Color.white.ignoresSafeArea()) // Full-page white background
    }
}

// Reusable Section Header
struct SectionHeader: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.black)
            .padding(.vertical, 5)
    }
}

// Reusable Information Card
struct InfoCard: View {
    var title: String
    var description: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.9, green: 0.2, blue: 0.3))
            Text(description)
                .font(.body)
                .foregroundColor(.gray)
                .lineLimit(3) // Optional: Truncates text after 3 lines
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

// Reusable Tip Item
struct TipItem: View {
    var iconName: String
    var tip: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: iconName)
                .font(.system(size: 20))
                .foregroundColor(Color(red: 0.9, green: 0.2, blue: 0.3))
            Text(tip)
                .font(.body)
                .foregroundColor(.black)
            Spacer()
        }
    }
}

// Reusable FAQ Card
struct FAQCard: View {
    var question: String
    var answer: String
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(question)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.gray)
            }
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }

            if isExpanded {
                Text(answer)
                    .font(.body)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

// MARK: - Data Model
struct Stage: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

let stageData = [
    Stage(title: "Proestrus", description: "This is the first stage lasting 7-10 days. Swelling of the vulva and light bleeding are common."),
    Stage(title: "Estrus", description: "This stage lasts 5-10 days. The female is receptive to mating, and fertility is at its peak."),
    Stage(title: "Diestrus", description: "Lasting 10-14 days, symptoms taper off, and the dog is no longer receptive to mating."),
    Stage(title: "Anestrus", description: "The resting phase, lasting 4-5 months. The body recovers and prepares for the next cycle.")
]

// Preview
struct DogEstrousCycleView_Previews: PreviewProvider {
    static var previews: some View {
        DogEstrousCycleView()
    }
}
