import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var photo: PhotoListCellViewModel?
    var thumbnailImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let data = photo else { fatalError("photo is nil") }
        
        self.photoImageView.image = thumbnailImage
        self.photoImageView.setImage(url: data.url)
        
        self.idLabel.text = "ID: \(data.id)"
        self.titleLabel.text = "Title: \(data.title)"
        self.titleLabel.numberOfLines = 0
        self.idLabel.alpha = 0
        self.titleLabel.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.2, delay: 0.2, options: [], animations: {
            self.idLabel.alpha = 1
            self.titleLabel.alpha = 1
        }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.idLabel.alpha = 0
        self.titleLabel.alpha = 0
    }
}

extension PhotoDetailViewController: ZoomingViewController {
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
        return photoImageView
    }
    
    func zoomingBackgroundView(for tansition: ZoomTransitioningDelegate) -> UIView? {
        return nil
    }
}
