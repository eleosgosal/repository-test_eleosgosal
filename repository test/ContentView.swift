//
//  ContentView.swift
//  repository test
//
//  Created by Eleos Gosal on 31/8/26.
//
//special text is t&c btw too lazy to change the name
import SwiftUI
//t&c
struct NewView: View {
    @Binding var specialtext: String
    var body: some View {
        VStack {
            Text("T&C")
                .font(.largeTitle)
            Text("By using KALC!, you agree to the following terms and conditions.")
            Text(specialtext)
        }
        .navigationTitle("t&c")
    }
}
//ui
struct ContentView: View {

    @State var display = "0"
    @State var number = 0
    @State var message = 0
    @State var operation = ""
    @State var equation = ""
    @State var newInput = true
    @State var specialtext = "1. Don't crash out"

    let buttons = [
        ["4", "3", "7", "1"],
        ["5", "=", "2", "9"],
        ["8", "6", "0", "+"],
        ["AC", "-", "*", "???"],
        ["show gratitute"]
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
        NavigationStack {
            VStack {
                Image("KALC!")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 225, height: 225)
                    .offset(y: -100)

                Text(equation.isEmpty ? display : equation)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.1))
                    )

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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        NewView(specialtext: $specialtext)
                    } label: {
                        Image(systemName: "questionmark.circle")
                    }
                }
            }
            .padding()
        }
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
            //final ans
            message = (message + 1) % trollmessages.count
            newInput = true
        }
        else if button == "show gratitute" {
            display = "thanks:D"
        }
        else if button == "???" {
            specialtext = "2. crash out."
        }
    }
}
#Preview {
    ContentView()
}
