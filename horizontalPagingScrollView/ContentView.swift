//
//  ContentView.swift
//  horizontalPagingScrollView
//
//  Created by Inpyo Hong on 2023/01/20.
//

import SwiftUI

struct CustomItem: Identifiable, Equatable {
    let id = UUID()
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
                        ForEach(Array(zip(colors.indices, colors)), id: \.0) { index, item in
                            Text("Item \(index)")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .frame(width: proxy.size.width, height: proxy.size.height)
                                .background(item.color)
                                .id(item.id)
                        }
                    }
                }.onAppear {
                    scrollView.scrollTo(colors[colors.count-1].id)
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
