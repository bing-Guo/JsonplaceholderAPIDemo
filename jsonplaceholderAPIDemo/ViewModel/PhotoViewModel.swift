import Foundation

class PhotoListCellViewModel {
    let id: String
    let title: String
    let url: URL
    let thumbnailUrl: URL
    
    init(albumId: Int, id: Int, title: String, url: URL, thumbnailUrl: URL) {
        self.id = "\(id)"
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
}


