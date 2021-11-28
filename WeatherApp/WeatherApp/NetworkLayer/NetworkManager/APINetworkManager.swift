//
//  APINetworkManager.swift
//  WeatherApp
//
//  Created by Abdullah Tariq on 11/27/21.
//
//

import Foundation
import Alamofire

enum Environment  {
    case dev
    case staging
    case production
}

class APINetworkManager{
    
    static let sharedInstance = APINetworkManager()
    
    static let environment: Environment = .dev
    
    private init(){}
    
    var environmenBasetUrl: String {
        switch APINetworkManager.environment {
        case .dev: return K.DEV_BASE_SERVER_URL
        case .staging: return K.STAGING_BASE_SERVER_URL
        case .production: return K.PROD_BASE_SERVER_URL
        }
    }
    
    //MARK: - Get Request API Generic Method
    func requestGetData<T>(params: Parameters, completion: @escaping (T?, _ error: String?)->()) where T: Codable {
        
        AF.request(
            environmenBasetUrl,
            method: .get,
            parameters: params,
            encoding: URLEncoding.default).responseJSON { response in
                switch response.result {
                case .success( _):
                    do {
                        let decoder = JSONDecoder()
                        if let jsonData = response.data {
                            let result = try decoder.decode(T.self, from: jsonData)
                            completion(result, nil)
                        }
                    }catch let error {
                        print(error)
                        completion(nil, K.ENCODING_ERROR)
                    }
                    break
                case .failure(_):
                    completion(nil, K.SERVER_NOT_RESPONDING)
                    break
                }
            }
    }
    //MARK: - Post Request API Generic Method
    func requestPostData<T>(params: Parameters, completion: @escaping (T?, _ error: String?)->()) where T: Codable {
        
        AF.request(
            environmenBasetUrl,
            method: .post,
            encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .success( _):
                    do {
                        let decoder = JSONDecoder()
                        if let jsonData = response.data {
                            let result = try decoder.decode(T.self, from: jsonData)
                            completion(result, nil)
                        }
                    }catch {
                        completion(nil, K.ENCODING_ERROR)
                    }
                    break
                case .failure(_):
                    completion(nil, K.SERVER_NOT_RESPONDING)
                    break
                }
            }
    }
    //MARK: - Image URL Fetch Network Call
    func setImageFromUrl(ImageURL :String, completion: @escaping (_ img: UIImage?)->()){
        URLSession.shared.dataTask( with: NSURL(string:ImageURL)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                if let data = data {
                    completion(UIImage(data: data))
                }
            }
        }).resume()
    }
    
}

