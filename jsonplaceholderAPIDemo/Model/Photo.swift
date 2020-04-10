import Foundation

struct Photo: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case albumId
        case id
        case title
        case url
        case thumbnailUrl
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        albumId = try values.decode(Int.self, forKey: .albumId)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        
        let urlString = try values.decode(String.self, forKey: .url)
        if let url = URL(string: urlString) {
            self.url = url
        } else {
            throw NSError(domain: "url.error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error occured to decode url."])
        }
        
        let thumbnailUrlString = try values.decode(String.self, forKey: .thumbnailUrl)
        if let url = URL(string: thumbnailUrlString) {
            self.thumbnailUrl = url
        } else {
            throw NSError(domain: "thumbnailUrl.error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error occured to decode thumbnailUrlString."])
        }
    }
}
