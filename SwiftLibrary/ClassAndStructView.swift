//
//  StructView.swift
//  SwiftLibrary
//
//  Created by Pieter Yoshua Natanael on 28/01/25.
//

import SwiftUI

//Why Structs are Common in SwiftUI
//Views in SwiftUI are structs because:
//They are lightweight and fast.
//SwiftUI relies on value types to rebuild the UI efficiently.
//Changes in the state trigger a new struct instance, making UI updates predictable.
//Classes in SwiftUI:
//Used for data models (ObservableObject) or when working with reference-based shared data.

//Online Book Shop Example
//Let's create an app with two components:
//
//A struct for the UI view.
//A class for managing shared data (book list).
//



// MARK: - Model
struct Book: Identifiable {
    let id: Int
    let title: String
    let author: String
    let price: Double
}

// MARK: - ViewModel
class BookListViewModel: ObservableObject {
    @Published var books: [Book] = []
    
    init() {
        fetchBooks()
    }
    
    func fetchBooks() {
        // Simulate fetching books from an API or database
        self.books = [
            Book(id: 1, title: "SwiftUI Essentials", author: "Apple", price: 29.99),
            Book(id: 2, title: "SwiftUI Essentials 2", author: "Apple", price: 39.99),
            Book(id: 3, title: "SwiftUI Essentials 3", author: "Apple", price: 49.99)
        ]
    }
}

// MARK: - Views

// MARK: BookListView
struct BookListView: View {
    // MARK: - StateObject for ViewModel
    @StateObject private var viewModel = BookListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.books) { book in
                NavigationLink(destination: BookDetailView(book: book)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(book.title)
                                .font(.headline)
                            Text("by \(book.author)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("$\(book.price, specifier: "%.2f")")
                            .font(.body)
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Online Book Shop")
        }
    }
}

// MARK: - BookDetailView
struct BookDetailView: View {
    let book: Book
    
    var body: some View {
        VStack(spacing: 20) {
            Text(book.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("by \(book.author)")
                .font(.title2)
                .foregroundColor(.secondary)
            
            Text("$\(book.price, specifier: "%.2f")")
                .font(.title)
                .foregroundColor(.green)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Book Details")
    }
}

// MARK: - Preview
#Preview {
    BookListView()
}


//
//Key Notes
//The data model (BookStore) is a class because it manages shared data, and SwiftUI needs to observe changes (@ObservableObject).
//The views (BookListView, BookDetailView) are structs because SwiftUI expects lightweight, immutable components that can be recreated efficiently.
//Next Steps
//Explore State Management: Learn about @State, @Binding, and @ObservedObject.
//Add Actions: Enhance the app with features like "Add to Cart" or "Mark as Favorite."
//
