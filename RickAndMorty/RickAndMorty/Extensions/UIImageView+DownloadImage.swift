//
//  UIImageView+DownloadImage.swift
//  RickAndMorty
//
//  Created by atakan yetkin on 11.04.2023.
//

import UIKit

extension UIImageView {
    public func downloadSetImage(url: String) {
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
            task.resume()
    }
    
}
