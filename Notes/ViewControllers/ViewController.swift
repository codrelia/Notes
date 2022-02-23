import UIKit

class ViewController: UIViewController {
    
    // Button for adding a new entry
    var addingAnEntry = UIButton()
    // Table where notes are stored
    var tableWithNotes = UITableView()
    // Label with information about the absence of notes
    var infoAboutEmptyNotes: UILabel = UILabel()
    
    
    // Checking for an early launch of the application. Calling the main methods for visualizing the application.
    override func viewDidLoad() {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if !launchedBefore  {
            notes.append(["Hi! This is the note that appears on the first launch.", currentDate()])
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        super.viewDidLoad()
        creatingATableWithNotes()
        buttonForAddingNotes()
        forLabelWithNoNotes()
        navigationItemEdit()
    }
    
    // Updating the table for new data
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableWithNotes.reloadData()
    }

    // Setting up the navigation bar
    func navigationItemEdit() {
        self.navigationItem.title = "Notes"
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editOfCells(_:)))
    }
    
    // Creating and configuring a table
    func creatingATableWithNotes() {
        tableWithNotes = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.maxX, height: self.view.frame.size.height), style: .plain)
        self.tableWithNotes.delegate = self
        self.tableWithNotes.dataSource = self
        self.view.addSubview(tableWithNotes)
    }
    
    // Adding a new note to the table
    func buttonForAddingNotes() {
        let imageOfAdd = UIImage(named: "add")
        addingAnEntry = UIButton(frame: CGRect(x: view.bounds.midX - 25, y: view.bounds.maxY - 100, width: 50, height: 50))
        addingAnEntry.setImage(imageOfAdd, for: .normal)
        addingAnEntry.sizeToFit()
        addingAnEntry.addTarget(self, action: #selector(addingANewNote(_:)), for: .touchUpInside)
        self.view.addSubview(addingAnEntry)
    }
    
    // Adding a controller to the stack, where further writing or editing of a note will take place
    func callingANewController() {
        let newViewController = ViewControllerWritingNotes()
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    // Setting up a label with information about missing notes
    func forLabelWithNoNotes() {
        infoAboutEmptyNotes = UILabel(frame: CGRect(x: view.bounds.midX - 22.5, y: view.bounds.midY, width: 50, height: 50))
        infoAboutEmptyNotes.text = "No Notes"
        infoAboutEmptyNotes.sizeToFit()
        infoAboutEmptyNotes.font = UIFont.systemFont(ofSize: 10)
    }
    
    // Action to click on the new record button
    @objc func addingANewNote(_ sender: Any) {
        currentIndex = -1
        callingANewController()
    }
    
    // Action to click on the edit button
    @objc func editOfCells(_ sender: Any) {
        tableWithNotes.setEditing(!tableWithNotes.isEditing, animated: true)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if notes.count != 0 {
            infoAboutEmptyNotes.removeFromSuperview()
            return notes.count
        }
        self.view.addSubview(infoAboutEmptyNotes)
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Id1")
        cell.textLabel?.text = notes[indexPath.row][0]
        cell.detailTextLabel?.text = notes[indexPath.row][1]
        cell.detailTextLabel?.textColor = UIColor.gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        callingANewController()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableWithNotes.deleteRows(at: [indexPath], with: .left)
        }
    }
    }

