//
//  ContentView.swift
//  repository test
//
//  Created by Eleos Gosal on 31/8/26.
//

import SwiftUI

struct ContentView: View {
    @State private var display = "0"
    @State private var number = 0
    @State private var operation = ""
    @State private var newInput = true

    let buttons = [
        ["7", "8", "9", "+"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "="],
        ["0"]
    ]

    var body: some View {
        VStack {
            Text(display)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .trailing)

            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { button in
                        Button(button) {
                            press(button)
                        }
                        .font(.title)
                        .frame(maxWidth: .infinity, minHeight: 60)
                    }
                }
            }
        }
        .padding()
    }

    func press(_ button: String) {
        if Int(button) != nil {
            if newInput {
                display = button
                newInput = false
            } else {
                display += button
            }
        }

        else if button == "+" || button == "-" {
            number = Int(display) ?? 0
            operation = button
            newInput = true
        }

        else if button == "=" {
            let second = Int(display) ?? 0

            if operation == "+" {
                display = "\(number + second)"
            } else if operation == "-" {
                display = "\(number - second)"
            }

            newInput = true
        }
    }
}

#Preview {
    ContentView()
}
