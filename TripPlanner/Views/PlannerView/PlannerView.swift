//
//  PlannerView.swift
//  TripPlanner
//
//  Created by Andrew Savitskiy on 27.01.2024.
//

import SwiftUI

struct PlannerView: View {
    @State private var viewModel: ViewModel
    @State private var showPopUp = false
    @State private var direction: Direction = .from
    
    init(tripManager: TripManagerProtocol) {
        self.viewModel = ViewModel(tripManager: tripManager)
    }
    
    var body: some View {
        ZStack {
            VStack {
                MapView(lineCoordinates: $viewModel.lineCoordinates)
                
                if let route = viewModel.route {
                    VStack(alignment: .leading) {
                        ScrollView(.horizontal, showsIndicators: true) {
                            HStack {
                            ForEach(route.0, id: \.self) { path in
                                Text(path.title)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .background(Color.blue)
                                    .cornerRadius(20.0)
                                if path != route.0.last {
                                    Image(systemName: "arrowshape.right")
                                        .foregroundColor(.blue)
                                }
                            }
                                Spacer()
                            }
                            .padding(.top, 4)
                            .padding(.bottom, 16)
                            .padding(.horizontal)
                        }
                        HStack {
                            Text("Total price: \(route.1)")
                                .font(.title2)
                                .foregroundStyle(Color.green)
                        }
                        .padding(.top, 0)
                        .padding(.bottom, 10)
                        .padding(.horizontal)
                        Divider()
                    }
                }
                    
                HStack {
                    Button {
                        direction = .from
                        withAnimation {
                            showPopUp.toggle()
                        }
                    } label: {
                        HStack {
                            Text(viewModel.locationFrom?.title ?? "Departure city")
                            Image(systemName: viewModel.locationFrom == nil ? "hand.tap" : "mappin.and.ellipse")
                                .imageScale(.large)
                                .foregroundStyle(.tint)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    Image(systemName: "airplane")
                        .imageScale(.large)
                        .foregroundColor(.blue)

                    Button {
                        direction = .to
                        withAnimation {
                            showPopUp.toggle()
                        }
                    } label: {
                        HStack {
                            Text(viewModel.locationTo?.title ?? "Destination city")
                            Image(systemName: viewModel.locationTo == nil ? "hand.tap" : "mappin.and.ellipse")
                                .imageScale(.large)
                                .foregroundStyle(.tint)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
                .padding(.horizontal)
            }
            .edgesIgnoringSafeArea(.top)
            
            if self.showPopUp {
                PopUpListView(items: $viewModel.locationList, show: $showPopUp, searchRequest: $viewModel.searchRequest) { location in
                    switch direction {
                    case .from:
                        viewModel.selected(from: location)
                    case .to:
                        viewModel.selected(to: location)
                    }
                    withAnimation {
                        self.showPopUp = false
                    }
                }
            }
        }
        .task {
            await viewModel.loadData()
        }
    }
}

#Preview {
    PlannerView(tripManager: TripManager(apiService: ApiService.shared))
}
