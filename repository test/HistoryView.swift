```swift
import SwiftUI

struct HistoryView: View {

    @Binding var history: [String]

    var body: some View {
        List {
            if history.isEmpty {
                Text("No answers saved yet.")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(history.reversed(), id: \.self) { answer in
                    Text(answer)
                }
            }
        }
        .navigationTitle("History")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Clear") {
                    history.removeAll()
                }
            }
        }
    }
}
```
