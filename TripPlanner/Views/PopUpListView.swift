//
//  PopUpListView.swift
//  TripPlanner
//
//  Created by Andrew Savitskiy on 30.01.2024.
//

import SwiftUI
import Foundation

struct PopUpListView<Item: Hashable & CustomStringConvertible>: View {
    @Binding var items: [Item]
    @Binding var show: Bool
    @Binding var searchRequest: String
    var selected: (Item) -> Void
        
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea(.all)
            VStack {
                VStack {
                    TextField("Search location...", text: $searchRequest)
                        .padding(.vertical, 4)
                        .padding(.horizontal)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.accent, lineWidth: 1)
                        )
                        .padding()
                    
                    ScrollView(.vertical) {
                        VStack {
                            ForEach(items, id: \.self) { item in
                                Button {
                                    selected(item)
                                } label: {
                                    HStack {
                                        Image(systemName: "mappin.and.ellipse")
                                            .font(.title)
                                            .foregroundColor(.accentColor)
                                        Spacer()
                                        Text(item.description).font(.headline)
                                        Spacer()
                                    }
                                    .padding()
                                }
                                Divider()
                            }
                        }
                        .padding()
                    }
                }
                .background(Color.white)
                .cornerRadius(10)

                Button {
                    withAnimation {
                        self.show = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.red)
                        .padding()
                }
                .background(Color.white)
                .clipShape(Circle())
                .padding(.top)
            }
            .frame(width: UIScreen.main.bounds.width * 0.8,
                   height: UIScreen.main.bounds.height * 0.8)
        }
    }
}
