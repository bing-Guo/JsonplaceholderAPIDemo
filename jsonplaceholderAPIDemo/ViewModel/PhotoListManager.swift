import Foundation

class PhotoListManager {
    private let photoService = PhotoService()
    var container = [PhotoListCellViewModel]()
    
    func fetchData(page: Int, perPage: Int, complete: @escaping ([PhotoListCellViewModel], Int, Int, Bool) -> Void) {
        photoService.searchPhoto(page: page, perPage: perPage) { photos, error in
            let start = self.container.count
            self.container += self.buildCellViewModels(photos: photos)
            let end = self.container.count
            
            let cellViewModels = self.buildCellViewModels(photos: photos)
            
            if photos.count > 0 {
                complete(cellViewModels, start, end, false)
            } else {
                complete(cellViewModels, start, end, true)
            }
        }
    }
    
    private func buildCellViewModels(photos: [Photo]) -> [PhotoListCellViewModel] {
        return photos.map { buildCellViewModel(photo: $0) }
    }
    
    private func buildCellViewModel(photo: Photo) -> PhotoListCellViewModel {
        return PhotoListCellViewModel(albumId: photo.albumId, id: photo.id, title: photo.title, url: photo.url, thumbnailUrl: photo.thumbnailUrl)
    }
}
