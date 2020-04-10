import Foundation

protocol Route {
    var host: String { get }
    func path() -> String
}

extension Route {
    func absoluteUrlString() -> String {
        guard var url = URL(string: host) else {
            fatalError("host is not an url")
        }
        url.appendPathComponent(path())
        return url.absoluteString
    }
}
