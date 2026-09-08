//
//  ContentView.swift
//  repository test
//
//  Created by Eleos Gosal on 31/8/26.
//
//special text is t&c btw too lazy to change the name
import SwiftUI
//ui
struct ContentView: View {

    @State var display = "0"
    @State var number = 0
    @State var message = 0
    @State var operation = ""
    @State var equation = ""
    @State var newInput = true
    @State var currentNumber = 0
    @State var powerswitch = true
    @State var history: [String] = []

    let buttons = [
        ["4", "3", "7", "1"],
        ["5", "=", "2", "9"],
        ["8", "6", "0", "+"],
        ["AC", "-", "*", "???"]
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

                Text(equation + display)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.1))
                    )
                    .contextMenu {
                        Button {
                            history.append(display)
                        }
                        label: {
                            Label("Add to History", systemImage: "clock.arrow.circlepath")
                        }
                    }
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
                Stepper(
                    "Number: \(currentNumber)",
                    value: $currentNumber,
                    in: 0...99999)
                .disabled(!powerswitch)
                .onChange(of: currentNumber) {
                    display = "\(currentNumber)"
                }
                Toggle("useless powerswitch", isOn: $powerswitch)
                    .padding(.horizontal)
                        .onChange(of: powerswitch) {
                            if !powerswitch {
                                display = "0"
                                number = 0
                                currentNumber = 0
                                operation = ""
                                equation = ""
                                newInput = true
                            }
                        }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        HistoryView(history: $history)
                    } label: {
                        Image(systemName: "clock.arrow.2.circlepath")
                    }
                }
            }
            .padding()
        }
    }
//button logics
    func press(_ button: String) {
//powerswitch
            if !powerswitch {
                return
            }
        if button == "AC" {
            display = "0"
            currentNumber = 0
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
            currentNumber = Int(display) ?? 0
        }
        
        else if button == "+" || button == "-" || button == "*" {
            
            if !operation.isEmpty {
                display = "too lazy to calculate"
                equation = ""
                    return
                }

                number = currentNumber
                operation = button
                equation = "\(number) \(button) "

                currentNumber = 0
                display = "0"
                newInput = true
        }
        
        else if button == "=" {
            
            let second = currentNumber
            
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
            equation = ""
            //final ans
            message = (message + 1) % trollmessages.count
            newInput = true
        }
    }
}
#Preview {
    ContentView()
}
