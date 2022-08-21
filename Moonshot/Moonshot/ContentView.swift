//
//  ContentView.swift
//  Moonshot
//
//  Created by SUNG HAO LIN on 2022/8/18.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State var isGrid: Bool = false
    
    let colums = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color.darkBackground)
    }
    
    @ViewBuilder
    private func gridView(missions: [Mission], astronauts: [String: Astronaut]) -> some View {
        ScrollView {
            LazyVGrid(columns: colums) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if !isGrid {
                    gridView(missions: missions, astronauts: astronauts)
                } else {
                    listView(missions: missions, astronauts: astronauts)
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        isGrid.toggle()
                    } label: {
                        Image(systemName: isGrid ? "square.split.2x2" : "list.bullet")
                            .accentColor(.white)
                    }
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
    
    @ViewBuilder
    private func listView(missions: [Mission], astronauts: [String: Astronaut]) -> some View {
        List(missions) { mission in
            NavigationLink {
                MissionView(mission: mission, astronauts: astronauts)
            } label: {
                HStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    
                    Text(mission.displayName)
                        .foregroundColor(.white)
                        .padding(.leading, 8)
                    
                    Spacer()
                    
                    Text(mission.formattedLaunchDate)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.5))
                        .padding(.trailing, 8)
                }
            }
            .listRowBackground(Color.darkBackground)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
