//
//  MissionView.swift
//  Moonshot
//
//  Created by COBE on 22/04/2021.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let mission: Mission
    let astronauts: [CrewMember]
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    GeometryReader { geo in
                        Image(self.mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: geometry.size.width*0.7)
                            .scaleEffect(max(0.8, min(1.0, geo.frame(in: .global).minY / (geometry.size.height / 8.8))))
                            .padding(.top)
                    }
                    Text(self.mission.formattedLaunchDate)
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role){
                        crewMember in
                        NavigationLink(
                            destination: AstronautView(astronaut: crewMember.astronaut)){
                            
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary,lineWidth: 1))
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                }
                            .padding(.horizontal)
                            }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName),displayMode: .inline)
    }
    init (mission: Mission, astronauts: [Astronaut]){
        self.mission = mission
        var matches = [CrewMember]()
        for member in mission.crew {
            if let match = astronauts.first(where: {
                $0.id == member.name
            }){
                matches.append(CrewMember(role: member.role, astronaut: match))
            }
            else {
                fatalError("Missing \(member)")
            }
        }
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
