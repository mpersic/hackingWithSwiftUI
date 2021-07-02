//
//  ContentView.swift
//  Accessibility
//
//  Created by COBE on 14/05/2021.
//

import SwiftUI

struct ContentView: View {
    let pictures = [
            "ales-krivec-15949",
            "galina-n-189483",
            "kevin-horstmann-141705",
            "nicolas-tissot-335096"
        ]
    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks"
    ]
    @State private var selectedPictures = Int.random(in: 0...3)
    @State private var estimate = 25.0
    var body: some View {
//        Image(pictures[selectedPictures])
//            .resizable()
//            .scaledToFit()
//            .accessibility(label: Text(labels[selectedPictures]))
//            .accessibility(addTraits: .isButton)
//            .accessibility(removeTraits: .isImage)
//            .onTapGesture {
//                self.selectedPictures = Int.random(in: 0...3)
//            }
        //Image(decorative: "character")
        //.accessibility(hidden: true)
//        VStack {
//            Text("Your score is")
//            Text("1000")
//                .font(.title)
//        }
//        .accessibilityElement(children: .ignore)
//        .accessibility(label: Text("Your score is 1000"))
        Slider(value: $estimate, in: 0...50)
            .padding()
            .accessibility(value: Text("\(Int(estimate))"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
