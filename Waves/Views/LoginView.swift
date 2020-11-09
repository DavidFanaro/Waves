//
//  LoginView.swift
//  Waves
//
//  Created by David Fanaro on 10/19/20.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var api: WavesApi
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack{
            TextField("Email", text: self.$email).padding().autocapitalization(.none)
            SecureField("Password", text: self.$password).padding()
            Button("Login") {
                api.login(email: self.email, password: self.password)
                api.defaults.set(self.email, forKey: "email")
                api.defaults.set(self.password, forKey: "password")
                print("login started")
            }
        }.padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
