//
//  File.swift
//  Waves
//
//  Created by David Fanaro on 10/19/20.
//

import SwiftUI

class WavesApi: ObservableObject {
    
    let defaultUrl = "https://waves-main-backend.herokuapp.com"
    let defaults = UserDefaults.standard
    
    
    @Published var user:User? {
        didSet{
            print("User Loggedin")
        }
    }
    
    @Published var songs:[Song]?{
        didSet{
            print("Songs Loaded")
        }
    }
    
    
    func login(email: String, password: String) {
    
        let params = [
            "email":email,
            "password":password
        ]
        
        let url =  URL(string: defaultUrl + "/api/v1/user/login")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: request){data , res, error in
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let user = try? JSONDecoder().decode(User.self, from: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self.user = user
            }
            
            
        }.resume()
    }
    
    func allSongs(){
        
        let url =  URL(string: defaultUrl + "/api/v1/songs")!
        
        let request = URLRequest(url: url)
        
        var songs:Songs?
        
        URLSession.shared.dataTask(with: request){data, res, err in
            
            guard err == nil else {
//                print(err?.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            do{
                songs = try JSONDecoder().decode(Songs.self, from: data)
                DispatchQueue.main.async {
                    self.songs = songs!.songs
                }
            }catch let err{
                print(err.localizedDescription)
            }
            
        }.resume()
        
    }
    
    
}
