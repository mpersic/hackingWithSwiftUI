//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by COBE on 10/04/2021.
//

import SwiftUI

struct CapsuleText : View {
    var text : String
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct Title : ViewModifier {
    func body (content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct WaterMark : ViewModifier {
    var text : String
    func body (content : Content) -> some View {
        ZStack(alignment: .bottomTrailing, content: {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        })
    }
}
//Create a custom ViewModifier (and accompanying View extension) that makes a view have a large, blue font suitable for prominent titles in a view.
extension View {
    func waterMarked(with text: String) -> some View {
        self.modifier(WaterMark(text: text))
    }
}

struct largeBlueFont : ViewModifier {
    var text: String
    func body (content: Content) -> some View {
        ZStack(content: {
            content
            Text(text)
                .font(.title)
                .foregroundColor(.blue)
        })
    }
}
extension View {
    func largeAndBlue(with text: String) -> some View {
        //self.modifier(WaterMark(text: text))
        self.modifier(largeBlueFont(text: text))
    }
}

extension View {
    func titleStyle () -> some View {
        self.modifier(Title())
    }
}

struct ContentView: View {
    var body: some View {
        Color.white
            .frame(width: 300, height: 300)
            .largeAndBlue(with: "test")
        Text("").largeAndBlue(with: "blue test")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
