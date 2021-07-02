//
//  AstronautView.swift
//  Moonshot
//
//  Created by COBE on 22/04/2021.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    var missionMatches = [String]()
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical){
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                }
                ForEach(missionMatches, id:\.self){ mission in
                    Text("\(mission)")
                        .font(.headline)
                }
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                }
            }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    init (astronaut: Astronaut){
        let missions: [Mission] = Bundle.main.decode("missions.json")
        self.astronaut = astronaut
        var matches = [String]()
        for mission in missions {
                    for _ in mission.crew {
                        if let match = mission.crew.first(where: {$0.name == astronaut.id}) {
                            matches.append("Apollo \(mission.id) - \(match.role)")
                            break
                        }
                    }
                }
        self.missionMatches = matches
    }
}


struct AstronautView_Previews: PreviewProvider {
    static let astronauts : [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
