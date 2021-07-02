//
//  ContentView.swift
//  BetterRest
//
//  Created by COBE on 12/04/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        let p = Binding<Int>(get: {
                    return self.coffeeAmount
                }, set: {
                    self.coffeeAmount = $0
                    calculateBedtime()
                })
        NavigationView{
            Form {
                Section(header: Text("When do you want to wake up?")){
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden().datePickerStyle(WheelDatePickerStyle())
                }
                VStack(alignment: .leading, spacing: 0, content: {
                    Text("Desired amount of sleep").font(.headline)
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25){
                        Text("\(sleepAmount, specifier: "%g") hours")
                            .accessibility(hidden: true)
                    }.padding()
                    .accessibility(value: Text("\(Double(sleepAmount)) hours of desired sleep"))
                    

                    Picker("Daily coffee intake", selection: p) {
                        ForEach(0 ..< 21){ amount in
                                if amount == 1 {
                                    Text("\(amount) cup")
                                }
                                else if amount > 1 {
                                    Text("\(amount) cups")
                                }
                            }
                    }
                    
                })
                Section(){
                    Text("\(alertTitle) \(alertMessage)")
                }
            }.navigationTitle("BetterRest")
            .navigationBarItems(trailing:
                    Button(action: calculateBedtime, label: {
                            Text("Calculate")
                     }
                )
                                    )
            .alert(isPresented: $showingAlert){
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK"))
            )}
        }
     }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedtime(){
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction (wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is..."
            
        }
        catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime"
            //something went wrong
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
