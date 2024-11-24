//
//  PackagesInFreightView.swift
//  ExpologHack
//
//  Created by Matheus Meneses on 23/11/24.
//

import SwiftUI

struct PackagesInFreightView: View {
    @State var searchText: String = ""
    @State var freight: Freight
    
    @ObservedObject var freightViewModel: FreightViewModel
    @ObservedObject var packageViewModel: PackageViewModel
    
    var body: some View {
                ZStack(alignment: .top) {
                    VStack {
                        VStack {
                            if !freight.packageArray.isEmpty {
                                SearchBar(text: $searchText)
                                    .padding(.vertical, 10)
                                List {
                                    ForEach(freight.packageArray.filter({searchText.isEmpty ? true : $0.name!.contains(searchText) })) { item in
                                        
                                        NavigationLink(destination: PackageInfoView(package: item, packageViewModel: packageViewModel)) {
                                            HStack {
                                                Text(item.name ?? "no name")
                                            }
                                        }
                                        
                                    }.onDelete(perform: { indexSet in
                                        indexSet.forEach { index in
                                            let package = freight.packageArray[index]
                                            FreightViewModel().deletePackageInFreight(package: package, freight: freight)
                                               
                                        }
                                    })
                                }
                            } else {
                                HStack {
                                    VStack(alignment: .center) {
                                        Spacer()
                                        Text("Adicione uma carga")
                                            .fontWeight(.regular)
                                            .font(.system(size: 15))
                                        Spacer()
                                    }
                                }
                                
                            }
                        }
                    }
                }.navigationTitle(freight.code!)
            
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(destination: EditGroupView(group: group,
//                                                              name: group.name ?? "",
//                                                              contactViewModel: contactViewModel)
//                        .onDisappear{groupViewModel.fetch()}
//                    ) {
//                        Text("Editar")
//                    }
//                }
//            }
    }
}
