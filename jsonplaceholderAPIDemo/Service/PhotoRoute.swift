import Foundation

enum PhotoRoute: String, Route {
    case photos
    
    var host: String {
        return "https://jsonplaceholder.typicode.com"
    }
    
    func path() -> String {
        return self.rawValue
    }
}
