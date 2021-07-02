//
//  ContentView.swift
//  HabbitTracker
//
//  Created by COBE on 26/04/2021.
//

import SwiftUI

class Activities: ObservableObject {
    @Published var activites = [Activity]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(activites) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }
    
    init() {
        if let activities = UserDefaults.standard.data(forKey: "Activities") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: activities) {
                self.activites = decoded
                return
            }
        }
        self.activites = []
    }
    
    public func addActivity(activity: Activity){
        activites.append(activity)
    }
    public func removeActivity(index: Int){
        activites.remove(at: index)
    }
}

struct DetailView: View {
    var name:String
    var description: String
    var activities: Activities
    var index: Int
    @State var dayCount: Int
    var body: some View {
        Text("Activity: \(name)")
            .font(.title)
        Text("Description: \(description)")
        Text("Days: \(dayCount)")
        Button("Add new day"){
            self.dayCount += 1
            activities.removeActivity(index: index)
            activities.addActivity(activity: Activity(name: name, description: description, count: dayCount))
        }
        Spacer()
    }
}

struct ContentView: View {
    @State private var userActivityName:String = ""
    @State private var userActivityDescription: String = ""
    @State private var userActivityDayCount = ""
    @State private var sheetIsPresented = false
    @ObservedObject var activities = Activities()
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(activities.activites){ activity in
                        NavigationLink(destination:
                                        DetailView(name: activity.name,
                                                   description: activity.description, activities: activities, index: activities.activites.firstIndex(of: activity) ?? 0,
                        dayCount: activity.count)){
                            Text(activity.name)
                        }
                    }
                    .onDelete(perform: delete)
                }
            }
            .sheet(isPresented: $sheetIsPresented){
                TextField("Enter your activity name", text: $userActivityName)
                TextField("Enter your activity description", text: $userActivityDescription)
                TextField("Enter your number of days", text: $userActivityDayCount)
                Button("Add"){
                    let days = Int(userActivityDayCount) ?? 0
                    let newActivity = Activity(name: userActivityName, description: userActivityDescription, count: days)
                    activities.addActivity(activity: newActivity)
                }
            }
            .navigationBarItems(trailing: Button("Add new activity"){
                self.sheetIsPresented.toggle()
            })
        }
        
    }
    func loadData(){
        activities.addActivity(activity: Activity(name: "Nogomet", description: "Zabava"))
        activities.addActivity(activity: Activity( name: "Kosarka", description: "Fun"))
    }
    func delete(at offsets: IndexSet) {
        activities.activites.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
