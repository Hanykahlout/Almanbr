//
//  ChartLeftData.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 16/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import Foundation
import Charts

class ChartLeftData: NSObject, AxisValueFormatter
{  
    func stringForValue(_ value: Double, axis: Charts.AxisBase?) -> String {
        if value.truncatingRemainder(dividingBy: 3) == 0{
            return "\(Int(value))"
        }
        return ""
    }
    
    
}


