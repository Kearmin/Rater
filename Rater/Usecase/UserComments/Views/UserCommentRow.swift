//
//  UserCommentRow.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 03. 13..
//  Copyright © 2020. Jenci. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserCommentRowContent: Identifiable {
    let id: Int
    let imageUrl: URL?
    let productName: String
    let commentText: String
    let rating: Int
}

struct UserCommentRow: View {
    
    let content: UserCommentRowContent
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            HStack(spacing: 5.0) {
                WebImage(url: self.content.imageUrl)
                    .resizable()
                    .placeholder(Image("noImage"))
                    .cornerRadius(10.0)
                    .overlay(RoundedRectangle(cornerRadius: 10.0).stroke(Color.gray, lineWidth: 1.0))
                    .frame(width: 65, height: 65, alignment: .leading)
                VStack(alignment: .leading) {
                    HStack {
                        RatingStar(percent: 1.0)
                        RatingStar(percent: content.rating > 1 ? 1.0 : 0.0)
                        RatingStar(percent: content.rating > 2 ? 1.0 : 0.0)
                        RatingStar(percent: content.rating > 3 ? 1.0 : 0.0)
                        RatingStar(percent: content.rating > 4 ? 1.0 : 0.0)
                    }
                    Text(content.productName)
                        .bold()
                        .lineLimit(nil)
                        .frame(width: nil, height: nil, alignment: .topLeading)
                }

            }
            Text(content.commentText)
            .lineLimit(nil)
        }
    }
}

struct UserCommentRow_Previews: PreviewProvider {
    static var previews: some View {
        UserCommentRow(content: UserCommentRowContent(id: 0, imageUrl: nil, productName: "alkshdjkashdjkahsjkdhaskdhakjshd", commentText: "asdhkashkjashjkfhasjfhjkashfkjashfjkasjkgasjkgjkaskhagsfhgashfgasjhfg", rating: 3))
    }
}
