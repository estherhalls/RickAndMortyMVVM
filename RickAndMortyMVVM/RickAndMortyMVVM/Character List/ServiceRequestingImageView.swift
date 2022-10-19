//
//  ServiceRequestingImageView.swift
//  RickAndMortyMVVM
//
//  Created by Esther on 10/19/22.
//

import UIKit
class ServiceRequestingImageView: UIImageView {

    private let service = APIService()
    func fetchImage(from url: URL) {
        let request = URLRequest(url: url)
            service.perform(request) { [weak self] result in
                switch result {
                case.failure:
                    print("Error fetching image")
                case.success(let imageData):
                    guard let image = UIImage(data: imageData) else { return }
                    DispatchQueue.main.async {
                        self?.contentMode = .scaleToFill
                        self?.image = image
                }
            }
        }
    }
}
