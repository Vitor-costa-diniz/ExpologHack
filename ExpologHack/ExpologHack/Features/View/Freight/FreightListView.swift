//
//  VehicleListView.swift
//  ExpologHack
//
//  Created by Matheus Meneses on 23/11/24.
//

import SwiftUI

struct FreightListView: View {
    @State var searchText: String = ""

    @ObservedObject var freightViewModel: FreightViewModel
    @ObservedObject var packageViewModel: PackageViewModel
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack {
                    VStack {
                        if !freightViewModel.freight.isEmpty {
                                SearchBar(text: $searchText)
                                    .padding(.bottom, 10)
                                List {
                                    ForEach(freightViewModel.freight.filter({searchText.isEmpty ? true : $0.code!.contains(searchText) })) { item in
                                        NavigationLink(destination: PackagesInFreightView(freight: item, freightViewModel: freightViewModel, packageViewModel: packageViewModel)) {
                                            HStack {
                                                Text(item.code ?? "no model")
                                            }
                                        }
                                    }.onDelete(perform: { indexSet in
                                        indexSet.forEach { index in
                                            let vehicle = freightViewModel.freight[index]
                                            FreightViewModel().deleteFreight(vehicle: vehicle)
                                        }
                                    })
                                }
                            } else {
                                HStack {
                                    VStack(alignment: .center) {
                                        Spacer()
                                        Text("Adicione um novo Frete clicando em +")
                                        .fontWeight(.regular)
                                        .font(.system(size: 15))
                                        Spacer()
                                    }
                                }

                            }
                    }

                }
            }
            .navigationTitle("Fretes")
               
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: NewFreightView(packageViewModel: packageViewModel, freightViewModel: freightViewModel)
                    ) {
                        Image(systemName: "plus")
                            .padding(.trailing, 20)
                            .padding(.top, 30)
                    }
                }
            }
        }
    }
}
