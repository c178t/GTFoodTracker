import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add tap gesture recognizer to the view
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    // This function will be called when the tap gesture recognizer detects a tap
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
