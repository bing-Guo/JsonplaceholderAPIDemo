import UIKit

class ThumbnailCollectionViewController: UICollectionViewController {
    private let perPage = 12
    private var page = 1
    
    var activityIndicator: UIActivityIndicatorView!
    var endOfScrollLabel: UILabel!
    
    private var photoListManager = PhotoListManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCollection()
        fetchPhotoData(page: self.page, perPage: self.perPage)
    }
    
    func setCollection() {
        self.collectionView!.register(UINib(nibName: "ThumbnailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ThumbnailCollectionViewCell.reuseIdentifier)
        self.collectionView!.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
        
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.itemSize = CGSize(width: collectionView.frame.width/4, height: collectionView.frame.width/4)
        flow.footerReferenceSize = CGSize(width: collectionView.frame.width, height: 40)
        
        self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: self.collectionView.frame.width, height: 40))
        
        self.endOfScrollLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.collectionView.frame.width, height: 40))
        self.endOfScrollLabel.isHidden = true
        self.endOfScrollLabel.textAlignment = .center
        self.endOfScrollLabel.text = "END"
        self.endOfScrollLabel.font = self.endOfScrollLabel.font.withSize(14)
        self.endOfScrollLabel.textColor = .lightGray
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoListManager.container.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCollectionViewCell.reuseIdentifier, for: indexPath) as? ThumbnailCollectionViewCell  else { return UICollectionViewCell() }
        
        if self.isEndOfScroll(row: indexPath.row) {
            self.fetchNextPage()
        }
        
        let photo = photoListManager.container[indexPath.row]
        cell.configure(id: String(photo.id),
                       title: photo.title,
                       imageUrl: photo.thumbnailUrl)
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photoListManager.container[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(identifier: "PhotoPage") as? PhotoDetailViewController {
            vc.photo = photo
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView = UICollectionReusableView()
        reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                       withReuseIdentifier: "Footer",
                                                                       for: indexPath)
        reusableView.backgroundColor = .clear

        reusableView.addSubview(activityIndicator)
        reusableView.addSubview(endOfScrollLabel)
        return reusableView
    }
    
    // MARK: Request
    func fetchNextPage() {
        self.page += 1
        self.fetchPhotoData(page: self.page, perPage: self.perPage)
    }
    
    func fetchPhotoData(page: Int, perPage: Int) {
        self.activityIndicator.startAnimating()
        photoListManager.fetchData(page: page, perPage: perPage) { data, start, end, isEnd in
            
            if isEnd {
                self.activityIndicator.stopAnimating()
                self.endOfScrollLabel.isHidden = false
                return
            }
            
            let insertIndexPaths = Array(start..<end).map { IndexPath(item: $0, section: 0) }
            self.collectionView.performBatchUpdates({
                self.collectionView.insertItems(at: insertIndexPaths)
                self.activityIndicator.stopAnimating()
            }, completion: nil)
            
            
        }
    }
    
    // Helper
    func isEndOfScroll(row: Int) -> Bool {
        return row >= (photoListManager.container.count - 1)
    }
}
