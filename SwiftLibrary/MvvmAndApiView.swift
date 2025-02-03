//
//  MvvmView.swift
//  SwiftLibrary
//
//  Created by Pieter Yoshua Natanael on 28/01/25.
//



//Why Model → ViewModel → View?
//Model comes first:
//The Model represents the data and business logic. It's the foundation of your app's architecture.
//Without the Model, there’s no data for the ViewModel to process or manage.
//It is like the raw material that needs processing.
//ViewModel is the bridge:
//The ViewModel connects the Model and the View.
//It takes raw data from the Model, processes or transforms it (if needed), and prepares it in a format that the View can easily display.
//The ViewModel also handles user actions (e.g., button taps) and updates the Model accordingly.
//View comes last:
//The View is the final step—it consumes the data provided by the ViewModel and renders the UI.
//It's purely focused on how things look and interact with the user.
//Why Isn’t It in the Name Order?
//Although Model-View-ViewModel (MVVM) lists the components as View → ViewModel → Model, the name represents their logical connection in the app, not the order of coding or data flow:
//
//The View is the starting point of interaction (user sees it first).
//The ViewModel provides data for the View.
//The Model is updated by actions initiated from the ViewModel.
//When coding, you’re building the foundation (Model), the logic (ViewModel), and then the interface (View). This ensures everything is set up properly for the View to function.
//
//Analogy:
//Think of a pizza-making process:
//
//Model = Ingredients (flour, cheese, tomato sauce, etc.).
//They’re raw and need preparation.
//ViewModel = The chef who prepares and arranges the ingredients into a pizza.
//It’s the middle layer that transforms raw materials into something usable.
//View = The served pizza.
//What the customer (user) sees and interacts with.



//
//Model  →  ViewModel  →  View
//(data)      (logic)       (UI)
//
//View  →  ViewModel  →  Model
//(user actions → processed → update data)




import SwiftUI

// MARK: - Model
struct Bread: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String
    let price: Double
}

// MARK: - ViewModel
class BreadListViewModel: ObservableObject {
    @Published var breads: [Bread] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    init() {
        fetchBreads()
    }
    
    func fetchBreads() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetchedBreads = try await simulateAPICall()
                DispatchQueue.main.async {
                    self.breads = fetchedBreads
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to load breads. Please try again."
                    self.isLoading = false
                }
            }
        }
    }
    
    // Simulate an API call with async/await
    private func simulateAPICall() async throws -> [Bread] {
        try await Task.sleep(nanoseconds: 2_000_000_000) // Simulate network delay (2 seconds)
        
        // Mock API data
        let mockData = [
            Bread(id: 1, name: "Sourdough", description: "A tangy and chewy bread.", price: 3.50),
            Bread(id: 2, name: "Baguette", description: "A classic French bread with a crispy crust.", price: 2.00),
            Bread(id: 3, name: "Ciabatta", description: "Italian bread with a soft and airy texture.", price: 2.75)
        ]
        return mockData
    }
}

// MARK: - Views
struct BreadListView: View {
    @StateObject private var viewModel = BreadListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading breads...") // Loading state
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 10) {
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            viewModel.fetchBreads()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                } else {
                    List(viewModel.breads) { bread in
                        NavigationLink(destination: BreadDetailView(bread: bread)) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(bread.name)
                                        .font(.headline)
                                    Text(bread.description)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Text("$\(bread.price, specifier: "%.2f")")
                                    .font(.body)
                                    .foregroundColor(.blue)
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }
            }
            .navigationTitle("Bread Shop")
        }
    }
}

struct BreadDetailView: View {
    let bread: Bread
    
    var body: some View {
        VStack(spacing: 20) {
            Text(bread.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(bread.description)
                .font(.title2)
                .foregroundColor(.secondary)
            
            Text("$\(bread.price, specifier: "%.2f")")
                .font(.title)
                .foregroundColor(.green)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Bread Details")
    }
}

// MARK: - Preview
#Preview {
    BreadListView()
}
