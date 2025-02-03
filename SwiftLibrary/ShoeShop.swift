//
//  ShoeShop.swift
//  SwiftLibrary
//
//  Created by Pieter Yoshua Natanael on 28/01/25.
//

import SwiftUI

// MARK: - Model (Shoe)

struct Shoe: Identifiable, Codable {
    let id: Int
    let name: String
    let brand: String
    let price: Double
}

// MARK: - ViewModel (ShoeStore)

class ShoeStore: ObservableObject {
    @Published var shoes: [Shoe] = []
    @Published var isLoading: Bool = false
    
    // Simulated API call using async/await
    func fetchShoes() async {
        isLoading = true
        do {
            // Simulating a network delay and fetching shoe data
            let url = URL(string: "https://api.example.com/shoes")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let shoes = try decoder.decode([Shoe].self, from: data)
            self.shoes = shoes // Updating the shoes array with the fetched data
        } catch {
            print("Error fetching shoes: \(error.localizedDescription)")
        }
        isLoading = false
    }
}

// MARK: - View (ShoeListView)

struct ShoeListView: View {
    @StateObject private var shoeStore = ShoeStore() // ViewModel
    
    // View body with the shoe list UI
    var body: some View {
        NavigationView {
            VStack {
                if shoeStore.isLoading {
                    ProgressView("Loading shoes...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    List(shoeStore.shoes) { shoe in
                        NavigationLink(destination: ShoeDetailView(shoe: shoe)) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(shoe.name)
                                        .font(.headline)
                                    Text("Brand: \(shoe.brand)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Text("$\(shoe.price, specifier: "%.2f")")
                                    .font(.body)
                                    .foregroundColor(.blue)
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    .navigationTitle("Shoe Shop")
                }
            }
            .onAppear {
                Task {
                    await shoeStore.fetchShoes() // Fetch the shoes when the view appears
                }
            }
        }
    }
}

// MARK: - View (ShoeDetailView)

struct ShoeDetailView: View {
    let shoe: Shoe
    
    // Detailed view of a shoe
    var body: some View {
        VStack(spacing: 20) {
            Text(shoe.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Brand: \(shoe.brand)")
                .font(.title2)
                .foregroundColor(.secondary)
            
            Text("$\(shoe.price, specifier: "%.2f")")
                .font(.title)
                .foregroundColor(.green)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Shoe Details")
    }
}

// MARK: - Preview

#Preview {
    ShoeListView()
}
