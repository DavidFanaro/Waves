//
//  ContentView.swift
//  Waves
//
//  Created by David Fanaro on 10/18/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var api: WavesApi

    
    @ViewBuilder
    var body: some View {
        
        if api.user != nil {
            AllSongs().onAppear{
                api.allSongs()
            }
        }else{
            LoginView().environmentObject(api).onAppear{
                if api.defaults.string(forKey: "email") != nil{
                    if api.defaults.string(forKey: "password") != nil{
                        api.login(email: api.defaults.string(forKey: "email")!, password: api.defaults.string(forKey: "password")!)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
