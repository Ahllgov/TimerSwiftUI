//
//  TimerViewModel.swift
//  TimerSwiftUI (iOS)
//
//  Created by Магомед Ахильгов on 17.10.2021.
//

import SwiftUI

//Timer model and data
class TimerData: ObservableObject {
    @Published var time: Int = 0
    @Published var selectedTime : Int = 0
    //Animation properties
    @Published var buttonAnimation = false
    //TimerViewData
    @Published var timerHeightChange : CGFloat = 0
}
