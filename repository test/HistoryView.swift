//
//  HistoryView.swift
//  repository test
//
//  Created by Eleos Gosal on 8/9/26.
//
import SwiftUI

struct HistoryView: View {

    @Binding var history: [String]

    var body: some View {
        List {
            if history.isEmpty {
                Text("The beginning of time...")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(history.reversed(), id: \.self) { answer in
                    Text(answer)
                }
            }
        }
        .navigationTitle("Answer history")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Clear") {
                    history.removeAll()
                }
            }
        }
    }
}
