//
//  TodoriWidgetLiveActivity.swift
//  TodoriWidget
//
//  Created by kwon ji won on 12/14/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TodoriWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct TodoriWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TodoriWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension TodoriWidgetAttributes {
    fileprivate static var preview: TodoriWidgetAttributes {
        TodoriWidgetAttributes(name: "World")
    }
}

extension TodoriWidgetAttributes.ContentState {
    fileprivate static var smiley: TodoriWidgetAttributes.ContentState {
        TodoriWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: TodoriWidgetAttributes.ContentState {
         TodoriWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: TodoriWidgetAttributes.preview) {
   TodoriWidgetLiveActivity()
} contentStates: {
    TodoriWidgetAttributes.ContentState.smiley
    TodoriWidgetAttributes.ContentState.starEyes
}
