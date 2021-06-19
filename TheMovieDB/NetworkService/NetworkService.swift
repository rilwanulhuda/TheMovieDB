//
//  NetworkService.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 16/06/21.
//

import Alamofire
import Foundation

enum FetchResutlt<Success, GeneralError> {
    case success(Success)
    case failure(GeneralError)
}

enum NetworkStatus {
    static var isInternetAvailable: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

protocol IEndpoint {
    var url: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
}

class NetworkService {
    static let share = NetworkService()
    private var dataRequest: DataRequest?

    @discardableResult func _dataRequest(endpoint: IEndpoint) -> DataRequest {
        return AF.request(endpoint.url,
                          method: endpoint.method,
                          parameters: endpoint.parameters,
                          encoding: endpoint.encoding,
                          headers: endpoint.headers)
    }

    func request<T: Decodable>(endpoint: IEndpoint, completion: @escaping (FetchResutlt<T, String>) -> Void) {
        guard NetworkStatus.isInternetAvailable else {
            let errorMsg = "No Internet Connection"
            print(errorMsg)
            completion(.failure(errorMsg))
            return
        }

        DispatchQueue.global(qos: .background).async {
            self.dataRequest = self._dataRequest(endpoint: endpoint)
            self.dataRequest?.validate().responseDecodable(decoder: JSONDecoder(), completionHandler: {
                (response: AFDataResponse<T>) in
                TRACER(endpoint, response)

                switch response.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error.localizedDescription))
                }
            })
        }
    }
}

private func TRACER<T: Any>(_ endpoint: IEndpoint, _ response: AFDataResponse<T>) {
    #if DEBUG
    let duration = response.metrics?.taskInterval.duration ?? 0
    let seconds = (duration * 10000).rounded() / 10000
    let request = response.request?.url?.description ?? "-"

    let trace = """
    ---------------------------------------TRACING START----------------------------------------
    [REQUEST]: \(endpoint.method.rawValue) \(request) '\(seconds)s'

    [HEADERS]: \(endpoint.headers == nil ? "-" : "\n" + (endpoint.headers!.dictionary.toJSON!))

    [ENCODING]: \(endpoint.encoding)

    [PARAMETERS]: \(endpoint.parameters == nil ? "-" : "\n" + (endpoint.parameters!.toJSON!))

    [RESPONSE]: \(response.data?.toJSON == nil ? "-" : "\n" + response.data!.toJSON!)
    ---------------------------------------TRACING STOP-----------------------------------------
    """
    print(trace.removeBackslash)
    #endif
}
