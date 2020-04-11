import Foundation

protocol PhotoServiceProtocol {
    func searchPhoto(page: Int, perPage: Int, complete: @escaping ([Photo], Error?) -> Void)
}

class PhotoService: PhotoServiceProtocol {
    private let service: NetworkService
    
    init(service: NetworkService = NetworkService()) {
        self.service = service
    }

    func searchPhoto(page: Int, perPage: Int, complete: @escaping ([Photo], Error?) -> Void) {
        let networkComplete: ([Photo]?, Error?) -> Void = { (response, error) in
            DispatchQueue.main.async {
                complete(response ?? [] , error)
            }
        }
        let param: [String: Any] = [
            "_limit": perPage,
            "_page": page
        ]
        
        service.getRequest(urlString: PhotoRoute.photos.absoluteUrlString(),
                           parameter: param,
                           complete: networkComplete)
    }
}

class FakePhotoService: PhotoServiceProtocol {
    func searchPhoto(page: Int, perPage: Int, complete: @escaping ([Photo], Error?) -> Void) {
        
        let networkComplete: ([Photo]?, Error?) -> Void = { (response, error) in
            DispatchQueue.main.async {
                complete(response ?? [] , error)
            }
        }
        
        let jsonPath = Bundle.main.path(forResource: "fakeResponse", ofType: "json")
        
        if let data = try? Data(contentsOf: URL(fileURLWithPath: jsonPath!)), let response = try? JSONDecoder().decode([Photo].self, from: data) {
            DispatchQueue.global().async {
                sleep(2)
                let start = (page-1) * perPage
                let end = page * perPage
                
                if start < response.count && end < response.count {
                    networkComplete(Array(response[start..<end]), nil)
                } else if start < response.count {
                    networkComplete(Array(response[start..<response.count]), nil)
                } else {
                    networkComplete(nil, NSError(domain: "nodata", code: -1, userInfo:nil))
                }
            }
        }
    }
}
