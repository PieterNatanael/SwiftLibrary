//
//  ToDoItem.swift
//  SwiftLibrary
//
//  Created by Pieter Yoshua Natanael on 05/02/25.
//


import Foundation

struct ToDoItem: Codable {
    let date: String
    let description: String
}

class ToDoManager {
    private var todos: [ToDoItem] = []
    private let fileName = "todos.json"
    
    init() {
        loadFromFile()
    }
    
    private func saveToFile() {
        if let data = try? JSONEncoder().encode(todos) {
            try? data.write(to: URL(fileURLWithPath: fileName))
        }
    }
    
    private func loadFromFile() {
        let fileURL = URL(fileURLWithPath: fileName)
        if let data = try? Data(contentsOf: fileURL),
           let loadedTodos = try? JSONDecoder().decode([ToDoItem].self, from: data) {
            todos = loadedTodos.sorted { $0.date < $1.date }
        }
    }
    
    func addItem(date: String, description: String) {
        todos.append(ToDoItem(date: date, description: description))
        todos.sort { $0.date < $1.date }
        saveToFile()
    }
    
    func searchItem(byDate date: String) -> [ToDoItem] {
        return todos.filter { $0.date == date }
    }
    
    func deleteItem(byDate date: String) {
        todos.removeAll { $0.date == date }
        saveToFile()
    }
    
    func listItems() {
        for todo in todos {
            print("\(todo.date): \(todo.description)")
        }
    }
}

func main() {
    let manager = ToDoManager()
    while true {
        print("1. Tambah To-Do\n2. Cari To-Do\n3. Hapus To-Do\n4. Tampilkan Semua\n5. Keluar")
        print("Pilih opsi: ", terminator: "")
        
        if let choice = readLine() {
            switch choice {
            case "1":
                print("Masukkan tanggal (YYYY-MM-DD): ", terminator: "")
                let date = readLine() ?? ""
                print("Masukkan deskripsi: ", terminator: "")
                let description = readLine() ?? ""
                manager.addItem(date: date, description: description)
            case "2":
                print("Masukkan tanggal untuk mencari: ", terminator: "")
                let date = readLine() ?? ""
                let results = manager.searchItem(byDate: date)
                for item in results {
                    print("\(item.date): \(item.description)")
                }
            case "3":
                print("Masukkan tanggal untuk menghapus: ", terminator: "")
                let date = readLine() ?? ""
                manager.deleteItem(byDate: date)
            case "4":
                manager.listItems()
            case "5":
                exit(0)
            default:
                print("Pilihan tidak valid.")
            }
        }
    }
}

main()
