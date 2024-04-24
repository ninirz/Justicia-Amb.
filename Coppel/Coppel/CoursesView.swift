//
//  CoursesView.swift
//  Coppel
//
//  Created by Wendy Sanchez Cortes on 24/04/24.
//

import SwiftUI

struct CoursesView: View {
    @State var showModal = false
    
    @State var courseCurrent = courses[0]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Cursos")
                    .font(.custom("Poppins-Bold", size: 50))
                    .frame(width: 260, alignment: .center)
                
                ForEach(courses) { course in
                    Button{
                        courseCurrent = course
                        showModal = true
                    } label: {
                        HCardView(courseSection: course)
                    }
                    
                }
            }
            .padding()
            .ignoresSafeArea()
            .sheet(isPresented: $showModal) {
                CourseView(course: courseCurrent )
            }
        }
    }
}

#Preview {
    CoursesView()
}

