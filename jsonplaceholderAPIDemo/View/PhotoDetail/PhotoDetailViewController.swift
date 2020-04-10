import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var photo: PhotoListCellViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.numberOfLines = 0
        
        guard let data = photo else { fatalError("photo is nil") }
        
        self.idLabel.text = "ID: \(data.id)"
        self.titleLabel.text = "Title: \(data.title)"
        
        self.photoImageView.image = UIImage(named: "default_image")
        self.photoImageView.setImage(url: data.url)
    }
}
