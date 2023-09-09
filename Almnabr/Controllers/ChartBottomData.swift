//
//  ChartBottomData.swift
//  Almnabr
//
//  Created by Hany Alkahlout on 16/10/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import Foundation
import Charts

public class ChartBottomData: NSObject, AxisValueFormatter {
    var data: [ProgressPlanedRatioResult]?
    
    init(data:[ProgressPlanedRatioResult]) {
        self.data = data
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return data?[Int(value)].month_plan_setting ?? "\(value)"
    }
    
}
