//
//  UserProfilePictureImageView.swift
//  justice-for-families
//
//  Created by Jules Labador on 5/17/21.
//

import Foundation
import SwiftUI

class UserProfilePictureImageViewModel: ObservableObject {
    
    var username: String
    @Published var image: UIImage = UIImage(named: "person.crop.circle")!
    
    init(username: String, isAnonymous: Bool) {
        self.username = username
        isAnonymous == false ? getImage() : nil
    }
    
    func getImage() {
        let imageCache = ImageCacheHelper.imagecache.object(forKey: username as NSString)
        if let image = imageCache?.image {
            self.image = image
        } else {
            Network.getProfilePicture(forUserEmail: username) { image in
                // Save the pfp to the cache
                let cache = ImageCache()
                cache.image = image
                ImageCacheHelper.imagecache.setObject(cache, forKey: self.username as NSString)
                
                self.image = image
            }
        }
    }
}

struct UserProfilePictureImageView: View {
    
    @StateObject var model: UserProfilePictureImageViewModel
    
    init(username: String, isAnon: Bool) {
        self._model = StateObject(wrappedValue: UserProfilePictureImageViewModel(username: username, isAnonymous: isAnon))
    }
    
    var body: some View {
        Image(uiImage: model.image)
            .resizable()
            .frame(width: 41, height: 41, alignment: .leading)
            .cornerRadius(41/2)
            .aspectRatio(contentMode: .fit)
            .clipped()
    }
}
