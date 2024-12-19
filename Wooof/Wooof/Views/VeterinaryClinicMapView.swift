import SwiftUI
import MapKit

// Custom Struct to Wrap Coordinates
struct Location: Identifiable {
    let id = UUID() // Unique ID for each location
    let coordinate: CLLocationCoordinate2D
}

struct VeterinaryClinicMapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 13.945154, longitude: 121.610957), // Centered around Lucena City
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    // Wrapped Locations
    let locations = [
        Location(coordinate: CLLocationCoordinate2D(latitude: 13.854942, longitude: 121.180198)),
        Location(coordinate: CLLocationCoordinate2D(latitude: 13.9486178, longitude: 121.6069666)),
        Location(coordinate: CLLocationCoordinate2D(latitude: 13.9419527, longitude: 121.6029447)),
        Location(coordinate: CLLocationCoordinate2D(latitude: 13.9467061, longitude: 121.6144155)),
        Location(coordinate: CLLocationCoordinate2D(latitude: 13.9449643, longitude: 121.6150818)),
        Location(coordinate: CLLocationCoordinate2D(latitude: 13.9411771, longitude: 121.6228886)),
        Location(coordinate: CLLocationCoordinate2D(latitude: 13.9706795, longitude: 121.6761661)),
        Location(coordinate: CLLocationCoordinate2D(latitude: 13.9705127, longitude: 121.6826868))
    ]

    var body: some View {
        NavigationView {
            ZStack {
                // Map View
                Map(coordinateRegion: $region, annotationItems: locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "pawprint.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.red)

                            Text("Vet Clinic")
                                .font(.caption)
                                .foregroundColor(.black)
                                .padding(4)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(8)
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)

                // Zoom Controls
                VStack {
                    Spacer()

                    HStack {
                        Spacer()

                        VStack(spacing: 10) {
                            Button(action: zoomIn) {
                                Image(systemName: "plus.magnifyingglass")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .clipShape(Circle())
                            }

                            Button(action: zoomOut) {
                                Image(systemName: "minus.magnifyingglass")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .clipShape(Circle())
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Vet Clinics in Lucena City")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: - Zoom In Function
    private func zoomIn() {
        region.span.latitudeDelta /= 2
        region.span.longitudeDelta /= 2
    }

    // MARK: - Zoom Out Function
    private func zoomOut() {
        region.span.latitudeDelta *= 2
        region.span.longitudeDelta *= 2
    }
}

struct VeterinaryClinicMapView_Previews: PreviewProvider {
    static var previews: some View {
        VeterinaryClinicMapView()
    }
}
