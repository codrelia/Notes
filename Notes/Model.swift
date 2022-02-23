import Foundation

var currentIndex: Int = -1
let formatter = DateFormatter()
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

func currentDate() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let myString = formatter.string(from: Date())
    let yourDate = formatter.date(from: myString)
    formatter.dateFormat = "dd MMM yyyy HH:mm:ss"
    let myStringDate = formatter.string(from: yourDate!)
    return myStringDate
}
