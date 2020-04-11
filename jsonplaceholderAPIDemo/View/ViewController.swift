import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var requestBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func requestBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(identifier: "ThumbnailCollectionPage") as? ThumbnailCollectionViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

