//
//  CircularProfileImageView.swift
//  MessengerClone
//
//  Created by Naresh Banavath on 08/07/24.
//

import SwiftUI
enum ProfileImageSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge
    
    var dimension: CGFloat {
        switch self {
        case .xxSmall: return 28
        case .xSmall: return 32
        case .small:  return 40
        case .medium: return 56
        case .large:  return 64
        case .xLarge: return 80
        }
    }
}
struct CircularProfileImageView: View {
    let user : User?
    let size : ProfileImageSize
    var body: some View {
        if let imageUrl = user?.profileImageURL {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.dimension, height: size.dimension)
                    .clipShape(Circle())
            } placeholder: {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: size.dimension, height: size.dimension)
                    .foregroundStyle(Color(.systemGray4))
                
            }
               
        }else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .foregroundStyle(Color(.systemGray4))
        }
    }
}

#Preview {
    CircularProfileImageView(user: .MOCK_USER, size: .xLarge)
}
