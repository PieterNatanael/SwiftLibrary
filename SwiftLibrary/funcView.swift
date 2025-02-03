//
//  funcView.swift
//  SwiftLibrary
//
//  Created by Pieter Yoshua Natanael on 30/01/25.
//

//A function (func) is a block of reusable code that performs a specific task. It helps keep your SwiftUI code organized, reusable, and modular.A function (func) is a block of reusable code that performs a specific task. It helps keep your SwiftUI code organized, reusable, and modular.



import SwiftUI

// ViewModel with function
class ViewModel: ObservableObject {
    func greenColor() -> Color {
        return .green
    }
}

struct funcView: View {
    var body: some View {
        ZStack {
            redToGreenGradients()
                .ignoresSafeArea()
            VStack {
                
                Text("$199.99")
                    .foregroundColor(getPriceColor(199.99))
                
                Text("$29.99")
                    .foregroundColor(getPriceColor(29.99))
                
                Text(formatPrice(99.99))
                    .font(.title)
                    .foregroundColor(.blue)
                
                Text(formatPrice(49.50))
                    .font(.headline)
                    .foregroundColor(.green)
            }
        }
    }
    
    
    //function that returns a gradients
    func blackToWhiteGradients() -> LinearGradient {
        return LinearGradient(
            gradient: Gradient(colors: [Color.black, Color.white]), startPoint: .top, endPoint: .bottom
        )
    }
    
    func redToGreenGradients() -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color.red, Color.green]), startPoint: .top, endPoint: .bottom)
    }
    
    
    // Function that returns a color based on price
     func getPriceColor(_ price: Double) -> Color {
         return price > 100 ? .red : .green
     }    // Function to format a number into a currency string
    func formatPrice(_ price: Double) -> String {
        return String(format: "$%.2f", price)
    }
}

#Preview {
    funcView()
}

//🔹 Why Use Functions in SwiftUI?
//Avoid Repetition – Instead of writing the same logic multiple times, create a function and call it when needed.
//Improve Readability – Breaking down code into small functions makes it easier to understand.
//Encapsulation – Functions keep logic separate from UI, making the code more maintainable.
//Reusability – Use the same function in multiple places instead of copying code.



//✅ Basic Functions: Defining and calling functions.
//✅ Functions in Views: Using functions to format text and return colors.
//✅ Functions in Buttons: Handling button taps with functions.
//✅ Functions with Closures: Running code after an API call.
//✅ Functions for Navigation: Opening a new screen.
