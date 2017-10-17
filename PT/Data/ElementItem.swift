//
// Created by Tolotra on 03/08/2017.
// Copyright (c) 2017 Etech. All rights reserved.
//

import ObjectMapper
import UIKit

class ElementItem: Mappable {

    var name:         String?
    var appearance:   String?
    var atomicMass:   Int?
    var boil:         Int?
    var category:     String?
    var density:      Double!
    var discoveredBy: String?
    var melt:         String?
    var molarHeat:    String?
    var namedBy:      String?
    var number:       Int?
    var period:       Int?
    var phase:        String?
    var source:       String?
    var spectralImg:  String?
    var summary:      String?
    var symbol:       String?
    var groupBlock:   String?
    var cpkHexColor:  String?
    var x:            Int?
    var y:            Int?

    required init?(_ map: Map) {

    }

    // Mappable
    func mapping(map: Map) {
        name          <- map["name"]
        appearance    <- map["appearance"]
        atomicMass    <- map["atomic_mass"]
        boil          <- map["boil"]
        category      <- map["category"]
        density       <- map["density"]
        discoveredBy  <- map["discovered_by"]
        molarHeat     <- map["molar_heat"]
        namedBy       <- map["named_by"]
        number        <- map["number"]
        period        <- map["period"]
        phase         <- map["phase"]
        source        <- map["source"]
        spectralImg   <- map["spectral_img"]
        summary       <- map["summary"]
        symbol        <- map["symbol"]
        cpkHexColor   <- map["cpkHexColor"]
        groupBlock    <- map["groupBlock"]
        x             <- map["xpos"]
        y             <- map["ypos"]
    }

    // Get the list of elements or empty array
    static func items() -> [ElementItem] {

        if let path = NSBundle.mainBundle().pathForResource("elements", ofType: "json") {
            do {
                let text = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                if let items = [ElementItem](JSONString: text) {
                    return items
                }

            } catch {
                return []
            }
        }

        return []
    }

    static func maxPoint() -> CGPoint {

        var maxX = 0
        var maxY = 0

        for item in items() {
            if item.x! > maxX {
                maxX = item.x!
            }

            if item.y! > maxY {
                maxY = item.y!
            }
        }

        return CGPoint(x: maxX, y: maxY)
    }

    func color() -> UIColor {

        if let c = self.groupBlock {
            switch c {
                case "actinoid":
                    return UIColor.fromHex("#312D2E")
                case "alkaline earth metal":
                    return UIColor.fromHex("#342C2A")
                case "alkali metal":
                    return UIColor.fromHex("#34252A")
                case "nonmetal":
                    return UIColor.fromHex("#293144")
                case "post-transition metal":
                    return UIColor.fromHex("#1E3744")
                case "noble gas":
                    return UIColor.fromHex("#332845")
                case "halogen":
                    return UIColor.fromHex("#2B2B45")
                case "lanthanoid":
                    return UIColor.fromHex("#2C2D2F")
                case "metalloid":
                    return UIColor.fromHex("#1E3744")
                case "transition metal":
                    return UIColor.fromHex("#242B33")
                case "metal":
                    return UIColor.fromHex("#203E34")
                default:
                    break;
            }
        }
        return UIColor.fromHex("#000000")
    }

}