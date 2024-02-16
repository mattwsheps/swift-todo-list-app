import SwiftUI

struct TodoItem: Identifiable {
    var id = UUID()
    var isChecked: Bool = false
    var task: String = ""
    var description: String = ""
    var dueDate: Date? = nil
}

struct ContentView: View {
    @State private var tasks: [TodoItem] = []
    @State private var newTask = ""

    var totalTodos: Double {
        let checkedTodos = tasks.filter { $0.isChecked }.count
        return Double(checkedTodos)
    }
    
    var percentageComplete: String {
        return String(format: "%.0f", (totalTodos / Double(tasks.count)) * 100)
    }

    var body: some View {
        NavigationView {
            List {
                VStack{
                    Image("todoIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    
                    if tasks.count > 0 {
                        Text("\(percentageComplete)% Complete")
                        ProgressView(value: totalTodos / Double(tasks.count))
                    } else {
                        Text("No tasks added")
                        ProgressView(value: 0)
                    }
                    
                }
                Section(header: Text("Add a new task")){
                    HStack {
                        TextField("Enter a task name", text: $newTask)
                        Button("Submit") {
                            guard !newTask.isEmpty else { return }
                            self.tasks.append(TodoItem(task: newTask))
                            newTask = ""
                        }
                    }
                }
                Section(header: Text("Tasks")) {
                    ForEach(tasks) { item in
                        NavigationLink(destination: TaskDisplayView(todoItem: self.binding(for: item))) {
                            Toggle(isOn: self.binding(for: item).isChecked) {
                                TextField("Enter a task name", text: self.binding(for: item).task)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        self.tasks.remove(atOffsets: indexSet)
                    }
                }
            }
        .navigationTitle("Todo List")
        }
    }

    private func binding(for task: TodoItem) -> Binding<TodoItem> {
        guard let taskIndex = tasks.firstIndex(where: { $0.id == task.id }) else {
            fatalError("Can't find task in array")
        }
        return $tasks[taskIndex]
    }
}

#Preview {
    ContentView()
}
