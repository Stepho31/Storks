//
//  ImageUploader.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/3/24.
//

import UIKit
import FirebaseStorage

enum ImageUploaderError: Error {
    case invalidData
}

struct ImageUploader {
    func uploadImage(image: UIImage) async throws -> String {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { throw ImageUploaderError.invalidData }
        let ref = Storage.storage().reference(withPath: "/profile_images/\(NSUUID().uuidString)")
        
        do {
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG: Failed to upload image \(error.localizedDescription)")
            throw error
        }
    }
}
