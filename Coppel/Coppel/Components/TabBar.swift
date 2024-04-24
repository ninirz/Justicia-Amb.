//
//  TabBar.swift
//  Coppel
//
//  Created by Wendy Sanchez Cortes on 23/04/24.
//

import SwiftUI
import RiveRuntime

struct TabBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                ForEach(tabItems) { item in
                    Button {
                        try? item.icon.setInput("active", value: true)
                        withAnimation {
                            selectedTab = item.tab
                        }
                    } label: {
                        item.icon.view()
                            .frame(width: 36, height: 36)
                            .frame(maxWidth: .infinity)
                            .opacity(selectedTab == item.tab ? 1 : 0.5)
                            .background(
                                VStack {
                                    RoundedRectangle(cornerRadius: 2)
                                        .frame(width: selectedTab == item.tab ? 20 : 0, height: 4)
                                        .offset(y: -4)
                                        .opacity(selectedTab == item.tab ? 1 : 0)
                                    Spacer()
                                }
                            )
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(12)
            .background(Color("BackColor").opacity(0.8))
            .background(.ultraThinMaterial)
            .mask(RoundedRectangle(cornerRadius: 26, style: .continuous))
            .padding(.horizontal, 24)
        }
    }

}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(selectedTab: .constant(.chat))
    }
}



