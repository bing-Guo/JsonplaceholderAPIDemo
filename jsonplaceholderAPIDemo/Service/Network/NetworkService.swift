import Foundation

class NetworkService {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func getRequest<T: Decodable>(urlString: String, parameter: [String: Any]?, complete: @escaping (T?, Error?) -> Void) {
        let request = compostRequest(urlString: urlString, parameter: parameter)
        
        session.dataTask(with: request) { (data, response, error) in
            if let data = data, let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) {
                do {
                    let jsonDecoder = JSONDecoder()
                    let result = try jsonDecoder.decode(T.self, from: data)
                    complete(result, nil)
                } catch let error {
                    complete(nil, error)
                }
            } else {
                complete(nil, error)
            }
        }.resume()
    }
    
    private func compostRequest(urlString: String, parameter: [String: Any]?) -> URLRequest {
        let urlWithQuery = urlString.appending(urlQuery(parameters: parameter))
        let request = URLRequest(url: URL(string: urlWithQuery)!)
        return request
    }
    
    private func urlQuery(parameters: [String: Any]?) -> String {
        var urlQuery: [String] = []
        if let parameters = parameters {
            urlQuery = parameters.reduce(into: urlQuery) { (res, tup) in
                let (key, value) = tup
                res.append("\(key)=\(value)")
            }
        }
        return "?\(urlQuery.joined(separator: "&"))"
    }

}
