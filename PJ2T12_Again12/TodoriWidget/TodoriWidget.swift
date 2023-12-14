//
//  TodoriWidget.swift
//  TodoriWidget
//
//  Created by kwon ji won on 12/14/23.
//

import WidgetKit
import SwiftUI
import CoreData

struct Provider: AppIntentTimelineProvider {
    
    //데이터를 불러오기전(getSnapshot)에 보여줄 Placeholder
    func placeholder(in context: Context ) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    // 홈화면에 있는 위젯을 언제 업데이트 시킬것인지 구현하는 부분
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            //한시간 간경으로 업데이트 하라는 코드
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }
        //.atEnd: 마지막 date가 끝난 후 reloading
        //.after: 다음 data가 지난 후 타임라인 reloading
        //.never: 즉시 타임라인 reloading
        return Timeline(entries: entries, policy: .atEnd)
    }
}


struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let todo = ["잠자기", "노트북닫기","코딩그만하기"]
    let wanttodo = ["호떡먹고싶다", "내일뭐먹지..", "하..언제끝나"]
}

struct TodoriWidgetEntryView : View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.date)],
        predicate: NSPredicate(format: "isTodo == true AND date >= %@ AND date <= %@", Calendar.current.startOfMonth(for: Date.now) as CVarArg, Calendar.current.endOfMonth(for: Date.now) as CVarArg)
    ) var todoList: FetchedResults<Todo>
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.date)],
        predicate: NSPredicate(format: "isTodo == false AND date >= %@ AND date <= %@", Calendar.current.startOfMonth(for: Date.now) as CVarArg, Calendar.current.endOfMonth(for: Date.now) as CVarArg)
    ) var wantTodoList: FetchedResults<Todo>
    
    var entry: Provider.Entry
    
    var body: some View {
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading){
                    Text("하고 싶으면")
                    VStack(alignment: .leading, spacing: 2) {
                        ForEach(wantTodoList) { wanttodo in
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: 150, height: 30)
                                //색깔 바꾸기
                                    .background(wanttodo.status ? Color.wanttoYesButtonBrown : Color.white)
                                    .foregroundColor(.clear)
                                    .cornerRadius(12)
                                Text(wanttodo.title ?? "" )
                                //                                .foregroundColor(Color.red)
                                    .foregroundColor(wanttodo.status ? Color.WanttoYesTextBrown : Color.TodoNoTextBrown)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                            }
                        }
                    }
                    Spacer()
                }
                .frame(width: 150)
                .padding(.bottom)
                VStack(alignment: .leading){
                    Text("해야 하면")
                    VStack(alignment: .leading, spacing: 2) {
                        ForEach(todoList) { todo in
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: 150, height: 30)
                                    .background(todo.status ? Color.TodoButtonBrown : Color.white)
                                    .foregroundColor(.clear)
                                    .cornerRadius(12)
                                Text(todo.title ?? "" )
                                    .foregroundColor(todo.status ? Color.white : Color.TodoNoTextBrown)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                            }
                        }
                    }
                }
                .frame(width: 150)
        }
    }
}

struct TodoriWidget: Widget {
    let kind: String = "TodoriWidget"
    let persistenceController = DataController.shared
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            TodoriWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

extension Calendar {
    func startOfMonth(for date: Date) -> Date {
        return self.date(from: self.dateComponents([.year, .month], from: self.startOfDay(for: date)))!
    }

    func endOfMonth(for date: Date) -> Date {
        return self.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth(for: date))!
    }
}


#Preview(as: .systemSmall) {
    TodoriWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}

