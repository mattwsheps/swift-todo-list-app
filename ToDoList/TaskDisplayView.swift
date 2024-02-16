import SwiftUI

struct TaskDisplayView: View {
    @Binding var todoItem: TodoItem
    
    var body: some View {
        VStack {
            Text("\(todoItem.task)")
            
            TextField("Description", text: $todoItem.description)
                .padding()
                .border(Color.gray, width: 1)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
           
            }
        .navigationTitle("\(todoItem.task)")
    }

}
