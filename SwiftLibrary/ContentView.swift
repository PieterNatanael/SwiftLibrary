//
//  ContentView.swift
//  SwiftLibrary
//
//  Created by Pieter Yoshua Natanael on 28/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel() // Create instance of ViewModel
      
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.largeTitle)
                .foregroundColor(viewModel.greenColor())
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
