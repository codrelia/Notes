import Foundation

// The current index that the user clicked on. If the index is -1, then the click did not occur.
var currentIndex: Int = -1
// Date Formatter
let formatter = DateFormatter()
// Two-dimensional array with notes and dates of their changes
var notes: [[String]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "Note")
        UserDefaults.standard.synchronize()
        
    }
    get {
        if let notes = UserDefaults.standard.array(forKey: "Note") as? [[String]] {
            return notes
        }
        else {
            return []
        }
    }
}

// Marks the current time
func currentDate() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let myString = formatter.string(from: Date())
    let yourDate = formatter.date(from: myString)
    formatter.dateFormat = "dd MMM yyyy HH:mm:ss"
    let myStringDate = formatter.string(from: yourDate!)
    return myStringDate
}
