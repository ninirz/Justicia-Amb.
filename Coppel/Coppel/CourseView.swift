//
//  CourseView.swift
//  Coppel
//
//  Created by Wendy Sanchez Cortes on 24/04/24.
//

import SwiftUI

struct CourseView: View {
    @State var course  = Course(title: "", subtitle: "", caption: "", color: Color(.yellowCoppel), image: Image("Topic 2"), imageProgram: Image("Programa1"))
    
    var body: some View {
        VStack{
            CourseCardView(courseInfo: course)
        }
        .ignoresSafeArea()
        .background(Color.yellowCoppel)
        
    }
        
}

#Preview {
    CourseView()
}
