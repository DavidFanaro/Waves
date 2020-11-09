//
//  SongCell.swift
//  Waves
//
//  Created by David Fanaro on 10/27/20.
//

import SwiftUI

struct SongCell: View {
    
    
    @State var name = ""
    
    var body: some View {
        Text(name).padding()
    }
}

struct SongCell_Previews: PreviewProvider {
    static var previews: some View {
        SongCell()
    }
}
