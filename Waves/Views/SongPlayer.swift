//
//  SongPlayer.swift
//  Waves
//
//  Created by David Fanaro on 10/27/20.
//

import SwiftUI
import AVFoundation
struct SongPlayer: View {
        
    @ObservedObject var player = Player()
    @State var seek = 0.0
    
    @ViewBuilder
    var body: some View {
        
        if(self.player.song != nil){
            
            VStack{
                Text(player.song?.title ?? "Song Title").font(.title).padding()
                Text(player.song?.desc ?? "Song Desc").font(.title2)
                Spacer()
                HStack{
                    Button(action: {
                        if (!player.isPlaying){
                            player.play()
                        }else{
                            player.pause()
                        }
                        
                    }, label: {
                        Image(systemName: player.isPlaying ? "pause.fill" : "play.fill" ).resizable().frame(width: 50,height: 50)
                    })
                    
                }
                
                
                
                Slider(value: $seek, in: 0...1) { _ in
                    guard let item = self.player.mediaPlayer?.currentItem else {
                        return
                    }
                    
                    let targetTime = self.seek * item.duration.seconds
                    self.player.mediaPlayer?.seek(to: CMTime(seconds: targetTime, preferredTimescale: 600))
                }.onAppear{
                    player.mediaPlayer?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: 600), queue: nil) { time in
                        guard let item = self.player.mediaPlayer?.currentItem else {
                            return
                        }
                        self.seek = time.seconds / item.duration.seconds
                    }
                }.padding()
                
                Spacer()
                HStack{
                    Spacer()
                    Text("User: \(player.song?.user ?? "No user")").font(.title2).padding()

                }
            }
            
        }else {
            Group{
                Text("No song has been selected yet").font(.callout).foregroundColor(.red).multilineTextAlignment(.center)
            }
        }
    }
}

//struct SongPlayer_Previews: PreviewProvider {
//    static var previews: some View {
//        //SongPlayer()
//    }
//}
