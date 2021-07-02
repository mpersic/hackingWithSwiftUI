//
//  ContentView.swift
//  LengthConverter
//
//  Created by COBE on 07/04/2021.
//

import SwiftUI

struct ContentView: View {
    @State var userInput: String = "meters"
    @State var lengthInput = ""
    @State var userOutputIndex = 0
    @State var userInputIndex = 0
    let lengthMeasurements = ["meters", "kilometers", "feet", "yards", "miles"]
    
    var userOutputMeasurement : String{
        return lengthMeasurements[userOutputIndex]
    }
    
    var userInputMeasurement : String{
        return lengthMeasurements[userInputIndex]
    }
    
    
    var lengthOutput: Double {
        let output = Double(Int(lengthInput) ?? 0)
        switch (userInputMeasurement, userOutputMeasurement) {
        case (lengthMeasurements[0],lengthMeasurements[0]),
             (lengthMeasurements[1],lengthMeasurements[1]),
             (lengthMeasurements[2],lengthMeasurements[2]),
             (lengthMeasurements[3],lengthMeasurements[3]),
             (lengthMeasurements[4],lengthMeasurements[4]):
            return output
        case ("meters","kilometers"):
            return output/1000
        case ("kilometers","meters"):
            return output*1000
        case ("kilometers","yards"):
            return output*1093.6133
        case ("kilometers","feet"):
            return output*3280.8399
        case ("kilometers","miles"):
            return output*0.621371192
        default:
            return 0.00
        }
    }
    
    var body: some View {
        NavigationView{
            Form {
                
                Section(header: Text("\(userInputMeasurement)")) {
                    TextField("Choose your length amount", text : $lengthInput)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("input measurement is \(userInputMeasurement)")) {
                    Picker("Choose your input measurement", selection: $userInputIndex){
                       ForEach(0..<lengthMeasurements.count){
                           Text("\(self.lengthMeasurements[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("output measurement is \(userOutputMeasurement)")) {
                     Picker("Choose your measurement", selection: $userOutputIndex){
                        ForEach(0..<lengthMeasurements.count){
                            Text("\(self.lengthMeasurements[$0])")
                         }
                     }
                     .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("\(userOutputMeasurement)")) {
                    Text("\(lengthOutput, specifier: "%.2f")")
                }
                
            }
            .navigationBarTitle("LengthConverter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
