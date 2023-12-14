//
//  TodoriWidgetBundle.swift
//  TodoriWidget
//
//  Created by kwon ji won on 12/14/23.
//

import WidgetKit
import SwiftUI

@main
struct TodoriWidgetBundle: WidgetBundle {
    var body: some Widget {
        TodoriWidget()
        TodoriWidgetLiveActivity()
    }
}
