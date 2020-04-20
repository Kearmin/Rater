//
//  UserCommentRow.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 03. 13..
//  Copyright © 2020. Jenci. All rights reserved.
//

import SwiftUI

struct UserCommentRowContent: Identifiable {
    let id: String = UUID().uuidString
    let image: Image
    let productName: String
    let commentText: String
}

struct UserCommentRow: View {
    
    let content: UserCommentRowContent
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            HStack(spacing: 5.0) {
                Image("E")
                    .resizable()
                    .cornerRadius(10.0)
                    .overlay(RoundedRectangle(cornerRadius: 10.0).stroke(Color.gray, lineWidth: 1.0))
                    .frame(width: 65, height: 65, alignment: .leading)
                Text(content.productName)
                    .bold()
                    .lineLimit(nil)
                    .frame(width: nil, height: nil, alignment: .topLeading)
            }
            Text(content.commentText)
            .lineLimit(nil)
        }
    }
}

struct UserCommentRow_Previews: PreviewProvider {
    static var previews: some View {
        UserCommentRow(content: UserCommentRowContent(image: Image("E"), productName: "alkshdjkashdjkahsjkdhaskdhakjshd", commentText: "asdhkashkjashjkfhasjfhjkashfkjashfjkasjkgasjkgjkaskhagsfhgashfgasjhfg"))
    }
}
