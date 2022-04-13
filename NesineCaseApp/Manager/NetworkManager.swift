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
    
    private var pendingRequestWorkItem: DispatchWorkItem?

    private init(){}
    
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
    
    func downloadAllImages(_ urls: [URL], completion: @escaping ([UIImage]) -> Void) {
        
        pendingRequestWorkItem?.cancel()
        
        let downloadDispatchWorkItem = DispatchWorkItem(qos: .utility) {
            let group = DispatchGroup()
            let semaphore = DispatchSemaphore(value: 3)
            var imageDictionary: [URL: UIImage] = [:]
            for url in urls {
                group.enter()
                semaphore.wait()
                KingfisherManager.shared.retrieveImage(with: url) { result in
                    defer {
                        semaphore.signal()
                        group.leave()
                    }
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let image):
                        DispatchQueue.main.async {
                            imageDictionary[url] = image.image
                        }
                    }
                }
            }
            group.notify(queue: .main) {
                completion(urls.compactMap { imageDictionary[$0] })
            }
        }
        
        let queue = DispatchQueue(label: "com.anil.que")
        queue.async(execute: downloadDispatchWorkItem)
        pendingRequestWorkItem = downloadDispatchWorkItem

    }
}
