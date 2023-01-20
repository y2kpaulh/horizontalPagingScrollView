//
//  ContentView.swift
//  horizontalPagingScrollView
//
//  Created by Inpyo Hong on 2023/01/20.
//

import SwiftUI

struct CustomItem: Identifiable, Equatable {
    var id: UUID = UUID()
    let color: Color
}

struct ContentView: View {
    let colors: [CustomItem] = [CustomItem(color: .purple), CustomItem(color: .pink), CustomItem(color: .orange)]
    
    var body: some View {
        GeometryReader { proxy in
            ScrollViewReader { scrollView in
                Button("Go to last index") {
                    scrollView.scrollTo(colors[colors.count-1].id)
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(colors) { item in
                            let index = colors.firstIndex(where: { $0 == item }) ?? 0
                            
                            Text("Item \(index)")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .frame(width: proxy.size.width, height: proxy.size.height)
                                .background(item.color)
                                .id(item.id)
                        }
                    }
                }.onAppear{
                    scrollView.scrollTo(colors[2].id)
                }
            }
        }
        .onAppear {
            UIScrollView.appearance().isPagingEnabled = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
