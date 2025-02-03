//
//  StructView.swift
//  SwiftLibrary
//
//  Created by Pieter Yoshua Natanael on 28/01/25.
//

import SwiftUI

struct StructView: View {
    var body: some View {
        ZStack {
            blackToWhiteGradients()
                .ignoresSafeArea()
            VStack {
                GradientRectangle()
                whiteRectangle()
                    .frame(width: 100, height: 100)
                Text("Hello World")
                number1()
                rectangle()
                    .frame(width: 100, height: 100)
            }
        }
    }
}

func whiteRectangle() -> some View {
    rectangle()
        .fill(Color.white)
}
func dividedBy2(_ number:Double) -> Double{
    return number / 2
}

func rectangle() -> Rectangle{
    return Rectangle()
}

func number1() -> Text{
    return Text("yes no 1")
}

func blackToWhiteGradients() -> LinearGradient{
    return LinearGradient (gradient: Gradient (colors: [Color.black, Color.white]), startPoint: .top, endPoint: .bottom)
}
//A struct is best when creating reusable SwiftUI views.
struct GradientRectangle: View {
    var body: some View {
        Rectangle()
            .fill(LinearGradient(
                gradient: Gradient(colors: [Color.red, Color.green]),
                startPoint: .top,
                endPoint: .bottom
            ))
            .frame(width: 200, height: 100)
    }
}



#Preview {
    StructView()
}
