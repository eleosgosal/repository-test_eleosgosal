//
//  ContentView.swift
//  repository test
//
//  Created by Eleos Gosal on 31/8/26.
//

import SwiftUI
//ui
struct ContentView: View {

    @State private var display = "0"
    @State private var number = 0
    @State private var message = 0
    @State private var operation = ""
    @State private var equation = ""
    @State private var newInput = true

    let buttons = [
        ["7", "8", "9", "*"],
        ["4", "5", "6", "+"],
        ["1", "2", "3", "-"],
        ["AC", "0", "", "="]
    ]

    let trollmessages = [
        "I think...",
        "Probably...",
        "Around...",
        "Hopefully...",
        "Perhaps...",
        "Should be..."
    ]

    var body: some View {
        VStack {
            Image("KALC!")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .offset(y: -100)

            Text(equation.isEmpty ? display : equation)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.1)))
            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { button in
                        Button(button) {
                            press(button)
                        }
                        .font(.title)
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.gray.opacity(0.2))
                        )
                    }
                }
            }
        }
        .padding()
    }
//button logics
    func press(_ button: String) {

        if button == "AC" {
            display = "0"
            number = 0
            operation = ""
            equation = ""
            newInput = true
            return
        }

        if Int(button) != nil {

            if newInput {
                display = button
                newInput = false
            } else {
                display += button
            }

            equation += button
        }

        else if button == "+" || button == "-" || button == "*" {

            number = Int(display) ?? 0
            operation = button
            newInput = true
            equation += " \(button) "
        }

        else if button == "=" {

            let second = Int(display) ?? 0

            var result = 0

            if operation == "+" {
                result = number + second
            }
            else if operation == "-" {
                result = number - second
            }
            else if operation == "*" {
                result = number * second
            }

            //approximation thing
            let numbersize = abs(result)

            let rounded: Int

            if numbersize < 100 {
                rounded = Int((Double(result) / 10).rounded()) * 10
            } else if numbersize < 1000 {
                rounded = Int((Double(result) / 100).rounded()) * 100
            } else if numbersize < 10000 {
                rounded = Int((Double(result) / 1000).rounded()) * 1000
            } else {
                rounded = Int((Double(result) / 10000).rounded()) * 10000
            }
            //lieslieslies
            var answer = rounded

            if Int.random(in: 1...5) == 1 {
                answer = Int.random(in: 1...99999)
            }

            display = "\(trollmessages[message]) \(answer)"
            equation = display

            //trollmessage part
            message = (message + 1) % trollmessages.count

            newInput = true
        }
    }
}

#Preview {
    ContentView()
}
