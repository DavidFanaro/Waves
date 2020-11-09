//
//  Songs.swift
//  Waves
//
//  Created by David Fanaro on 10/27/20.
//

import Foundation


struct Songs: Codable {
    var songs:[Song]
}

struct Song: Codable, Identifiable, Equatable {
    var id: String
    var user: String
    var title: String
    var desc: String
    var url: String
}
