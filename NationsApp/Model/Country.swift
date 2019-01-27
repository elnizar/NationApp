//
//  Coutry.swift
//  NationsApp
//
//  Created by Nizar Elhraiech on 2019-01-25.
//  Copyright © 2019 Nizar. All rights reserved.
//

import Foundation

struct Country : Decodable {
    let id : String?
    let enabled : String?
    let code3l : String?
    let code2l : String?
    let name : String?
    let officialName : String?
    let flag : String?
    let latitude : String?
    let longitude : String?
    let zoom : String?
    var distance : Double?
    
    init(id: String ,enabled: String, code3l: String, code2l: String, name: String, officialName: String, flag: String, latitude: String, longitude: String, zoom: String, distance: Double) {
        self.id = id
        self.enabled =  enabled
        self.code3l = code3l
        self.code2l = code2l
        self.name = name
        self.officialName = officialName
        self.flag = flag
        self.latitude = latitude
        self.longitude = longitude
        self.zoom = zoom
        self.distance = distance
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let value = try? container.decode(Int.self, forKey: .id) {
            id = String(value)
        } else {
            id = try container.decode(String.self, forKey: .id)
        }
        
        enabled = try container.decode(String.self, forKey: .enabled)
        code3l = try container.decode(String.self, forKey: .code3l)
        code2l = try container.decode(String.self, forKey: .code2l)
        name = try container.decode(String.self, forKey: .name)
        officialName = try container.decode(String.self, forKey: .officialName)
        flag = try container.decode(String.self, forKey: .flag)
        if let value = try? container.decode(Double.self, forKey: .latitude) {
            latitude = String(value)
        } else if let stringVal = try? container.decode(String.self, forKey: .latitude){
            latitude = stringVal
        } else {
            latitude = ""
        }
        
        if let value = try? container.decode(Double.self, forKey: .longitude) {
            longitude = String(value)
        } else if let stringVal = try? container.decode(String.self, forKey: .longitude){
            longitude = stringVal
        } else {
            longitude = ""
        }
        zoom = try container.decode(String.self, forKey: .zoom)
        distance = 0
    }

}

extension Country {
    enum CodingKeys: String, CodingKey {
        case id
        case enabled
        case code3l
        case code2l
        case name
        case officialName = "name_official"
        case flag
        case latitude
        case longitude
        case zoom
    }
}
