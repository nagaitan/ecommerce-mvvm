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
    
    func getListProduct() -> Observable<([Category], [PromoItem])>{
        let request = manager.request(homeURLString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
        return request.rx_JSON()
            .mapJSONResponse()
            .map { response in
                print("Isi Response \(response.result)")
                if response.code != 200 {
                    throw NSError(domain: "APIErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: response.message])
                }
                    var categories = [Category]()
                    var promoItems = [PromoItem]()
                    for cat in response.result["category"].arrayValue {
                        if let catItem = Category.with(json: cat) {
                            categories.append(catItem)
                        }
                    }
                    for pro in response.result["productPromo"].arrayValue {
                        if let proItem = PromoItem.with(json: pro) {
                            promoItems.append(proItem)
                        }
                    }
                    
                    return (categories, promoItems)
        }
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
            let code = 200;
            let message = "";
            var result = json;
            
            if json.arrayValue[0]["data"].exists(){
                result = json.arrayValue[0]["data"]
            }

            return APIResponse(code: code, message: message, result: result)
        }
    }
}


extension DataRequest{
    func rx_JSON(options: JSONSerialization.ReadingOptions = .allowFragments) -> Observable<JSON> {
        let observable = Observable<JSON>.create { observer in
            self.responseJSON(options: options) { response in
                if let error = response.result.error {
                    _ = String(data: response.data!, encoding: String.Encoding.utf8)
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

