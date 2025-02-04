//
//  ClassView.swift
//  SwiftLibrary
//
//  Created by Pieter Yoshua Natanael on 03/02/25.
//

import SwiftUI

// Superclass (Parent)
class Animal {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func makeSound() {
        print("Some generic animal sound")  // Default behavior
    }
}

// Subclass (Child)
class Cat: Animal {
    func meow() {
        print("Meoww")

    }

    // Override the makeSound() method from Animal
    override func makeSound() {
        super.makeSound()
        print("Purr... Meow!")  // Customized for Cat
    }
}

struct ClassView: View {
    let myCat = Cat(name: "Whiskers")  // Cat is still an Animal
    
    var body: some View {
        VStack {
            Text("Animal's Name: \(myCat.name)")  // ✅ Inherited property from Animal
            
            Button("Make Cat Meow") {
                myCat.meow()  // ✅ Unique to Cat
            }
            
            Button("Make Animal Sound") {
                myCat.makeSound()  // ✅ Overridden method in Cat
            }
        }
        .padding()
    }
}

#Preview {
    ClassView()
}

//Summary
//Without override → Subclass uses the parent's method as-is.
//With override → Subclass changes the method to fit its own behavior.
//Using super.method() → Subclass keeps the parent’s behavior but adds more functionality.
