//
//  APINetworkManager.swift
//  WeatherApp
//
//  Created by Abdullah Tariq on 11/27/21.
//
//

import Foundation
import Alamofire
//import SwiftyJSON

class APINetworkManager{
    
    static let sharedInstance = APINetworkManager()
    
    private init(){}

    func requestPostWithParamData<T>(baseURL: String, params: Parameters, headers: HTTPHeaders, completion: @escaping (T?, _ error: String?)->()) where T: Codable {
        
        AF.request(
            baseURL,
            method: .post,
            parameters: params,
            encoding: JSONEncoding.prettyPrinted,
            headers : headers).responseJSON { response in
                switch response.result {
                case .success(let result):
                    do {
                        let decoder = JSONDecoder()
                        if let jsonData = response.data {
                            let result = try decoder.decode(T.self, from: jsonData)
                            completion(result, nil)
                        }
                    }catch {
                        completion(nil, "Encoding Error")
                        print(error)
                    }
                    break
                case .failure(_):
                    completion(nil, "Server Not Reponding")
                    break
                }
            }
    }
    
    func requestGetData<T>(baseURL: String, headers: HTTPHeaders, completion: @escaping (T?, _ error: String?)->()) where T: Codable {
    
        AF.request(
            baseURL,
            method: .get,
            encoding: JSONEncoding.default,
            headers : headers).responseJSON { response in
                switch response.result {
                case .success(let result):
                    do {
                        let decoder = JSONDecoder()
                        if let jsonData = response.data {
                            let result = try decoder.decode(T.self, from: jsonData)
                            completion(result, nil)
                        }
                    }catch {
                        completion(nil, "Encoding Error")
                        print(error)
                    }
                    break
                case .failure(_):
                    completion(nil, "Server Not Reponding")
                    break
                }
            }
    }
    
    func requestPostData<T>(baseURL: String, headers: HTTPHeaders, completion: @escaping (T?, _ error: String?)->()) where T: Codable {
    
        AF.request(
            baseURL,
            method: .post,
            encoding: JSONEncoding.default,
            headers : headers).responseJSON { response in
                switch response.result {
                case .success(let result):
                    do {
                        let decoder = JSONDecoder()
                        if let jsonData = response.data {
                            let result = try decoder.decode(T.self, from: jsonData)
                            completion(result, nil)
                        }
                    }catch {
                        completion(nil, "Encoding Error")
                        print(error)
                    }
                    break
                case .failure(_):
                    completion(nil, "Server Not Reponding")
                    break
                }
            }
    }
    
}
