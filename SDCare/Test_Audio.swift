//
//  Test_Audio.swift
//  SDCare
//
//  Created by Vasapol Aurean on 30/3/2566 BE.
//

import SwiftUI
import AVKit

struct Test_Audio: View {
    @State var audioPlayer: AVAudioPlayer!
    @State var audioPlayer1: AVAudioPlayer!
    var body: some View {
        VStack{
            Button(action: {
                self.audioPlayer.play()
            }) {
                Image(systemName: "play.circle.fill").resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
            }
        }.onAppear {
            let sound = Bundle.main.path(forResource: "Pink noise TED", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            let sound1 = Bundle.main.path(forResource: "White Noise 500Hz", ofType: "mp3")
            self.audioPlayer1 = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound1!))
        }
    }
}

struct Test_Audio_Previews: PreviewProvider {
    static var previews: some View {
        Test_Audio()
    }
}
