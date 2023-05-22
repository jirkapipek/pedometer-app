import SwiftUI

struct DistanceView: View {
    let distance: Double
    
    var body: some View {
        Text("Ušli jste \(String(format: "%.2f", distance)) metrů.")
            .font(.title)
            .fontWeight(.bold)
            .padding()
    }
}
