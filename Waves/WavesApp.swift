//
//  WavesApp.swift
//  Waves
//
//  Created by David Fanaro on 10/18/20.
//

import SwiftUI

@main
struct WavesApp: App {
    
    var wavesApi = WavesApi()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(wavesApi)
        }
    }
}
