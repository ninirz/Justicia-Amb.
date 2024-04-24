//
//  HCardView.swift
//  Coppel
//
//  Created by Wendy Sanchez Cortes on 23/04/24.
//

import Foundation
import SwiftUI

struct HCardView: View {
    var courseSection = courses[0]
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text(courseSection.title)
                    .customFont(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(courseSection.caption)
                    .customFont(.body)
            }
            Divider()
            courseSection.image
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: 110)
        .foregroundColor(.white)
        .background(courseSection.color)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

struct HCardView_Previews: PreviewProvider {
    static var previews: some View {
        HCardView()
    }
}
