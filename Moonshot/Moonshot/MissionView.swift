//
//  MissionView.swift
//  Moonshot
//
//  Created by SUNG HAO LIN on 2022/8/20.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    missionHeaderView(mission,
                                      maxWidth: geometry.size.width)

                    missionInfoView(mission)
                    
                    missionAstronautView(crew)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    @ViewBuilder
    private func missionHeaderView(_ mission: Mission, maxWidth: CGFloat) -> some View {
        Image(mission.image)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: maxWidth * 0.6)
            .padding(.top)
        
        HStack {
            Text("LaunchDate: ")
                .foregroundColor(.white)
                .bold()
            
            Text(mission.formattedLaunchDate)
                .foregroundColor(.white)
                
            Spacer()
        }
        .padding(.top, 4)
        .padding(.leading, 20)
    }
    
    @ViewBuilder
    private func missionInfoView(_ mission: Mission) -> some View {
        VStack(alignment: .leading) {
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.lightBackground)
                .padding(.vertical, 4)
            
            Text("Mission Highlights")
                .font(.title.bold())
                .padding(.bottom, 5)
            
            Text(mission.description)
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.lightBackground)
                .padding(.vertical)
            
            Text("Crew")
                .font(.title.bold())
                .padding(.bottom, 5)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func missionAstronautView(_ crew: [CrewMember]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                
                                Text(crewMember.role)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
