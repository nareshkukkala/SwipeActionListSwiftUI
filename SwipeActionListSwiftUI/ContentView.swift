//
//  ContentView.swift
//  SwipeActionListSwiftUI
//
//  Created by naresh kukkala on 02/05/22.
//

import SwiftUI

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let photo: String
}

func getPlaces() -> [Place] {
    return [Place(name: "Denver", photo: "denver"),
            Place(name: "Newyork", photo: "ny"),
            Place(name: "Costa Rica", photo: "costa-rica"),
            Place(name: "Seattle", photo: "seattle"),
            Place(name: "Cuba", photo: "cuba")
    ]
}

struct ContentView: View {

    @State private var search: String = ""
    @State private var places = getPlaces()
    
    var body: some View {
        
        NavigationView {
            List(places) { place in
                HStack(alignment: .top) {
                    Image(place.photo)
                        .resizable()
                        .frame(maxWidth: 100, maxHeight: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    
                    Text(place.name)
                        .font(.title)
                }.swipeActions(edge: .leading) {
                    Button {
                        //action
                    } label: {
                        Label("Heart", systemImage: "heart.circle")
                    }.tint(.yellow)
                }
                .swipeActions(edge: .trailing) {
                    Button {
                        //action
                    } label: {
                        Label("Archive", systemImage: "heart.circle.fill")
                    }.tint(.teal)
                }
            }.listStyle(.plain)
            .searchable(text: $search)
            .onChange(of: search, perform: { value in
                if !value.isEmpty && value.count >= 1 {
                    places = places.filter {
                        $0.name.lowercased().hasPrefix(value.lowercased())
                    }
                } else {
                    places = getPlaces()
                }
            })
            
            
            .navigationTitle("Places")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
