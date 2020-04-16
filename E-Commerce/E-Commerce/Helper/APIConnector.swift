//
//  APIConnector.swift
//  E-Commerce
//
//  Created by Adi Wibowo on 16/04/20.
//  Copyright © 2020 Adi Wibowo. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

struct APIResponse {
    var code: Int
    var message: String
    var result: JSON
    
    init(code: Int, message: String, result: JSON) {
        self.code = code
        self.message = message
        self.result = result
    }
}

class APIConnector: NSObject {
    static let instance = APIConnector()
    let manager: APIManager
    let homeURLString : String
    
    override init() {
        homeURLString = "https://private-4639ce-ecommerce56.apiary-mock.com/home"
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        manager = APIManager(configuration: configuration)
        super.init()
    }
    
}

class APIManager: SessionManager {
    
    override func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> DataRequest {
        var overridedParameters = [String : AnyObject]()
        let overridedHeaders = [String: String]()
        
        if let parameters = parameters {
            overridedParameters = parameters as [String : AnyObject]
        }
        
        return super.request(url, method: method, parameters: overridedParameters, encoding: encoding, headers: overridedHeaders)
    }
    
}

extension Observable {
    func mapJSONResponse() -> Observable<APIResponse> {
        return map { (item: Element) -> APIResponse in
            guard let json = item as? JSON else {
                fatalError("Not a JSON")
            }
            print("to be mapped: ", json)
            var code = 200;
            var message = "";
            var result = json;
            if json["error"].exists(){
                if json["statusCode"].exists() {
                    code = json["statusCode"].intValue
                }
            } else if json["data"].exists() {
                result = json["data"]
            } else {
                result = json
            }
            if json["message"].exists() {
                message = json["message"].stringValue
            }
            return APIResponse(code: code, message: message, result: result)
        }
    }
}


extension DataRequest{
    func rx_JSON(options: JSONSerialization.ReadingOptions = .allowFragments) -> Observable<JSON> {
        let observable = Observable<JSON>.create { observer in
//            if let method = self.request?.httpMethod, let urlString = self.request?.url {
////                print("[\(method)] \(urlString)")
//                if let body = self.request?.httpBody {
////                    print(NSString(data: body, encoding: String.Encoding.utf8.rawValue))
//                }
//            }
            
            self.responseJSON(options: options) { response in
                if let error = response.result.error {
                    _ = String(data: response.data!, encoding: String.Encoding.utf8)
//                    print(string)
                    observer.onError(error)
                } else if let value = response.result.value {
                    let json = JSON(value)
                    if let error = json.error {
                        observer.onError(error)
                    } else {
                        observer.onNext(json)
                        observer.onCompleted()
                    }
                    
                } else {
                    observer.onError(NSError(domain: "APIErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown Error"]))
                }
            }
            return Disposables.create(with: self.cancel)
        }
        return Observable.deferred { return observable }
    }
}

