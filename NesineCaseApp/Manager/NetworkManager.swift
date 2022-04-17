//
//  NetworkManager.swift
//  NesineCaseApp
//
//  Created by Anıl Taha Uyar on 9.04.2022.
//

import Foundation
import Alamofire
import Kingfisher

public let BASE_URL = "https://itunes.apple.com/search?"

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let queue = OperationQueue()
    
    private init(){
        queue.maxConcurrentOperationCount = 3
    }
    
    func getSoftware(ofURL url:URL, callback:@escaping (SearchModel.Response?,Error?)->Void) {
        
        AF.request(url).validate().responseDecodable { (response: AFDataResponse<SearchModel.Response>) in
            
            NSLog("Requesting: \(url.description)")
            switch response.result {
            case .success(let responseModel):
                callback(responseModel, nil)
            case .failure(let error):
                NSLog("Request failed! \(error.localizedDescription)")
                callback(nil, error)
            }
        }
    }
    
    
    func downloadImage(_ url: URL, completion: @escaping (UIImage) -> Void) {
        var image = UIImage()
        KingfisherManager.shared.retrieveImage(with: url) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let resultImage):
                image = resultImage.image
                completion(image)
            }
        }
    }
    
    //low performance a lot of request
    func downloadImageOp(_ url: URL, completion: @escaping (UIImage) -> Void) {
        queue.addOperation {
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                      return
                  }
            completion(image)
        }
    }
    
    //good performance but a lot of requests no cache
    func downloadImageOpUrl(_ url: URL, completion: @escaping (UIImage) -> Void) {
        queue.addOperation {
            URLSession.shared.dataTask(with: url) {
                data, response, error in
                
                guard let data = data,
                      let image = UIImage(data: data) else {
                          return
                      }
                completion(image)
            }.resume()
        }
    }
    
    //Cache and download images  good performance but hight memory usage
    func downloadImageOpKing(_ url: URL, completion: @escaping (UIImage) -> Void) {
        queue.addOperation {
            KingfisherManager.shared.retrieveImage(with: url) { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let resultImage):
                    completion(resultImage.image)
                }
            }
        }
        
    }
    
    func cancelTask() {
        queue.cancelAllOperations()
    }
}
