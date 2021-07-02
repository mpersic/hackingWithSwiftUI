//
//  ContentView.swift
//  FriendsFace
//
//  Created by COBE on 03/05/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var users:[User]
    var body: some View {
        List(users, id: \.id) { user in
            
            Text(user.id)
                .font(.headline)
            Text(user.name)
                .font(.subheadline)
            
        }
        .onAppear {

        apiCall().getUsers { (users) in

        self.users = users

        }
    }
}
}
/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(users: [User]())
    }
}*/
