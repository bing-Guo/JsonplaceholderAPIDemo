import UIKit

class ThumbnailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    static let reuseIdentifier = "ThumbnailCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleLabel.numberOfLines = 2
        self.thumbnailImage.image = UIImage(named: "default_image")
    }

    func configure(id: String, title: String, imageUrl: URL) {
        self.idLabel.text = id
        self.titleLabel.text = title
        self.thumbnailImage.setImage(url: imageUrl)
    }
    
    func snapShotForTransition() -> UIView! {
        let snapShotView = UIImageView(image: self.thumbnailImage.image)
        snapShotView.frame = thumbnailImage.frame
        return snapShotView
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbnailImage.image = UIImage(named: "default_image")
    }
}
