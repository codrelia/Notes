import UIKit

class ViewControllerWritingNotes: UIViewController {
    
    var textFieldForNotes = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarForNewNotes()
        createATextFieldForNotes()
    }
    
    func navigationBarForNewNotes() {
        self.navigationItem.largeTitleDisplayMode = .never
        let imageOfSavingANote = UIImage(named: "done")
        let buttonOfDone = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(saveANote(_:)))
        buttonOfDone.image = imageOfSavingANote
        let buttonForDelete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteANote(_:)))
        buttonForDelete.tintColor = UIColor.red
        self.navigationItem.rightBarButtonItems = [buttonOfDone, buttonForDelete]
    }
    
    func createATextFieldForNotes() {
        textFieldForNotes = UITextView(frame: CGRect(x: 10, y: 0, width: self.view.bounds.maxX - 10, height: self.view.bounds.maxY))
        
        textFieldForNotes.contentInsetAdjustmentBehavior = .automatic
        textFieldForNotes.font = UIFont.systemFont(ofSize: 20)
        if currentIndex != -1 {
            textFieldForNotes.text = notes[currentIndex][0]
        }
        self.view.addSubview(textFieldForNotes)
    }
    
    @objc func saveANote(_ sender: Any) {
        if textFieldForNotes.text != "" {
            if currentIndex == -1 {
                notes.insert([textFieldForNotes.text, currentDate()], at: 0)
            }
            else {
                notes.remove(at: currentIndex)
                notes.insert([textFieldForNotes.text, currentDate()], at: 0)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteANote(_ sender: Any) {
        let newActionForDelete = UIAlertAction(title: "Yes", style: .default, handler: { _ in
            if currentIndex != -1 {
                notes.remove(at: currentIndex)
            }
            self.navigationController?.popViewController(animated: true)
        })
        let newAlert = UIAlertController(title: "Delete", message: "Are you sure you want to delete the note?", preferredStyle: .alert)
        let newActionForCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        newAlert.addAction(newActionForCancel)
        newAlert.addAction(newActionForDelete)
        self.present(newAlert, animated: true, completion: nil)
    }
    
}


