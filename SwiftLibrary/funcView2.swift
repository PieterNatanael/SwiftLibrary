//
//  funcView2.swift
//  SwiftLibrary
//
//  Created by Pieter Yoshua Natanael on 30/01/25.
//

import SwiftUI

struct funcView2: View {
    @State private var userInput: String = ""
    @State private var result: Double?

    func divideByTwo(_ number: Double) -> Double {
        return number / 2
    }

    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter a number", text: $userInput)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Divide by 2") {
                if let number = Double(userInput) {
                    result = divideByTwo(number)
                    
                    
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            if let result = result {
                Text("Result: \(result)")
                    .font(.title)
                    .padding()
            }
        }
        .padding()
    }
}


#Preview {
    funcView2()
}
