//
//  VCardView.swift
//  Coppel
//
//  Created by Wendy Sanchez Cortes on 24/04/24.
//

import SwiftUI

struct VCardView: View {
    @State var currentHability = habilidades[0]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Habiliad")
                .customFont(.title2)
                .frame(maxWidth: 170, alignment: .leading)
                .layoutPriority(1)
            Text("Puntaje de la habiliad")
                .opacity(0.7)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Descripajajsjaksjkjasassssdjhsdsdksjdsdkjksdllsdklksdlksldkkjskdjhsjdjshdjsnjdhsjdbsjbdjcjsjsdbsd")
                .customFont(.footnote2)
                .opacity(0.7)
            HStack{
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")
                Spacer(minLength: 50)
                Text("10/10")
                    .customFont(.title2)
                    .frame(maxWidth: 170, alignment: .leading)
                    .layoutPriority(1)
            }
           
            
            
            Spacer()
            HStack {
                ForEach(Array([1, 2, 3].shuffled().enumerated()), id: \.offset) { index, number in
                    Image("Programa\(number)")
                        .resizable()
                        .mask(Circle())
                        .frame(width: 44, height: 44)
                        .offset(x: CGFloat(index * -20))
                }
            }
        }
        .foregroundColor(.white)
        .padding(30)
        .frame(width: 260, height: 310)
        .background(.red)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .overlay(
            Image("Topic 2")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(20)
        )
    }
}

struct VCard_Previews: PreviewProvider {
    static var previews: some View {
        VCardView()
    }
}


struct VCardView_Previews: PreviewProvider {
    static var previews: some View {
        VCardView()
    }
}
