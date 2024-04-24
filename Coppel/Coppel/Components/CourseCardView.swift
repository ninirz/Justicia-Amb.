//
//  CourseCardView.swift
//  Coppel
//
//  Created by Wendy Sanchez Cortes on 24/04/24.
//


import Foundation
import SwiftUI

struct CourseCardView: View {
    var courseInfo = courses[0]
    
    var body: some View {
            ZStack {
                VStack(){
                    RoundedRectangle(cornerRadius: 30)
                        .background(courseInfo.color)
                        .overlay(
                            VStack(alignment: .leading, spacing: 8) {
                                Text(courseInfo.title)
                                    .customFont(.title2)
                                    .frame(maxWidth: .infinity, alignment: .center)
    
                                courseInfo.imageProgram
                                    .resizable()
                                    .frame(maxWidth: 500, maxHeight: 240)
                                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                                
                                Text(courseInfo.caption)
                                    .customFont(.body)
                                
                                Button(action: {
                                    // Acción del botón
                                }) {
                                    Text("Más imporfomación")
                                }
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: 500, maxHeight: 50)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                            }
                                .padding(20)
                        )
                }
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
}

struct CourseCardView_Previews: PreviewProvider {
    static var previews: some View {
        CourseCardView()
    }
}

