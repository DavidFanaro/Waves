//
//  AllSongs.swift
//  Waves
//
//  Created by David Fanaro on 10/27/20.
//

import SwiftUI
import SwiftUIRefresh
struct AllSongs: View {
    
    @EnvironmentObject var api: WavesApi
    
    @State private var isShowing = false
    
    @ObservedObject var player:Player = Player()
    
    
    @ViewBuilder
    var body: some View {
        
        let player = SongPlayer()
        
        NavigationView{
            if api.songs != nil{
                List(api.songs!){ song in
                    NavigationLink(
                        destination: player.onAppear{
                            if player.player.song != song{
                                player.player.loadSong(song: song)
                            }
                        },
                        label: {
                            SongCell(name: song.title)
                        })
                    
                }.navigationBarTitle("Songs").pullToRefresh(isShowing: $isShowing) {
                    api.allSongs()
                    self.isShowing = false
                }.navigationBarItems(leading: Group{
                    
                        NavigationLink("Now Playing", destination: player)
                    
                    
                })
            }else{
                //                Text("Error loading songs")
                ProgressView().progressViewStyle(CircularProgressViewStyle())
            }
        }
        
    }
}

//struct AllSongs_Previews: PreviewProvider {
//    static var previews: some View {
//        AllSongs()
//    }
//}
