import SwiftUI

struct MenstrualDataCard: View {
    var icon: String
    var iconHexColor: String
    var label: String
    var detail: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(Color(hex: iconHexColor))
                .font(.title3)

            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(.subheadline)
                    .foregroundColor(.primary)

                Text(detail)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

