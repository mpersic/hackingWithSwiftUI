//
//  ContentView.swift
//  Moonshot
//
//  Created by COBE on 21/04/2021.
//

import SwiftUI

struct CustomText: View {
    var text: String
    var body: some View {
        Text(text)
    }
    init(_ text: String){
        print("Creating a custom text")
        self.text = text
    }
}

//        VStack{
//            GeometryReader { geo in
//
//                Image("1760835")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: geo.size.width, height: geo.size.height)
//            }
//        }
//        ScrollView(.vertical){
//            VStack(spacing: 10){
//                ForEach(0..<100){
//                    CustomText("Item \($0)")
//                        .font(.title)
//                }
//            }
//            .frame(maxWidth: .infinity)
//        }
//        NavigationView {
//            List(0..<100) { row in
//                NavigationLink  (destination: Text("Detail \(row)")){
//                Text("Row \(row)")
//                }
//            }
//            .navigationBarTitle("Swift UI")
//        }
//        Button("Decode JSON"){
//            let input = """
//            {
//                "name": "Taylor Swift",
//                "address": {
//                    "street": "555, Taylor Swift Avenue",
//                    "city": "Nashville"
//                }
//            }
//            """
//            struct User: Codable {
//                var name: String
//                var address: Address
//            }
//            struct Address: Codable {
//                var street: String
//                var city: String
//            }
//            let data = Data(input.utf8)
//            let decoder = JSONDecoder()
//            if let user = try? decoder.decode(User.self, from: data){
//                print(user.address.street)
//            }
//        }

struct ContentView: View {
    @State private var showingDate = true
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    var body: some View {
        NavigationView {
            List(missions){ mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if showingDate {
                        Text(mission.formattedLaunchDate)
                        }
                        else {
                            Text(mission.formattedCrewMates)
                        }
                        //print(mission.formattedCrewMates)
                    }
                    //Make a bar button in ContentView that toggles between showing launch dates and showing crew names.
            }
                .accessibilityElement(children: .ignore)
                .accessibility(value: Text("\(mission.description)"))
                .navigationBarItems(trailing: Button("Toggle mission information"){
                    self.showingDate.toggle()
                })
            .navigationBarTitle("Moonshot")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
