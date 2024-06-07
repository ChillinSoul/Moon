//
//  utils.swift
//  Moon
//
//  Created by Axel Bergiers on 07/06/2024.
//

import UIKit

func saveImage(image: UIImage, fileName: String) -> Bool {
    guard let data = image.pngData() else { return false }
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let fileURL = paths[0].appendingPathComponent(fileName)
    
    do {
        try data.write(to: fileURL)
        return true
    } catch {
        print("Unable to save image to local storage:", error)
        return false
    }
}

func loadImage(fileName: String) -> UIImage? {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let fileURL = paths[0].appendingPathComponent(fileName)
    
    if FileManager.default.fileExists(atPath: fileURL.path) {
        return UIImage(contentsOfFile: fileURL.path)
    }
    return nil
}

