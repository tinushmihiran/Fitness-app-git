import UIKit
import FirebaseFirestore

class BMIViewController: UIViewController, UITextFieldDelegate {
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let field: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter Schedule Name"
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        return field
    }()
    
    let database = Firestore.firestore()
    
    // Declare saveButton as an instance property
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Add label, field, and save button as subviews
        view.addSubview(label)
        view.addSubview(field)
        view.addSubview(saveButton)
        
        // Set the text field's delegate to self
        field.delegate = self
        
        // Set the save button's target and action
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        let docRef = database.document("/Schedules/ScheduleData")
        docRef.addSnapshotListener { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            guard let text = data["text"] as? String else {
                return
            }
            
            DispatchQueue.main.async {
                self?.label.text = text
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Calculate the center Y position based on the safe area insets
        let centerY = view.safeAreaInsets.top + (view.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom) / 2
        
        // Set the frames of the label, text field, and save button
        label.frame = CGRect(x: 10, y: centerY - 100, width: view.bounds.width - 20, height: 100)
        field.frame = CGRect(x: 10, y: centerY - 25, width: view.bounds.width - 140, height: 50)
        saveButton.frame = CGRect(x: field.frame.maxX + 10, y: field.frame.minY, width: view.bounds.width - field.frame.maxX - 20, height: 50)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty {
            saveData(text: text)
        }
        return true
    }
    
    func saveData(text: String) {
        let docRef = Firestore.firestore().document("/Schedules/ScheduleData")
        docRef.setData(["text": text])
    }
    
    @objc func saveButtonTapped() {
        if let text = field.text, !text.isEmpty {
            saveData(text: text)
            field.text = ""
        }
    }
}
