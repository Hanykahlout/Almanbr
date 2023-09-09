//
//  LockScreenWidget.swift
//  LockScreenWidget
//
//  Created by Hany Alkahlout on 19/09/2022.
//  Copyright © 2022 Samar Akkila. All rights reserved.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
        
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct LockScreenWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    
    var body: some View {
        switch widgetFamily{
        case .accessoryCircular:
            Gauge(value: 0.5) {
                
                Image("qr-code")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22, alignment: .top)
                    .foregroundColor(.white)
                
            }.gaugeStyle(.accessoryCircular)
                .widgetURL(URL(string: "widget-deeplink://")!)
        default:
            ZStack {

                Color.init("AccentColor")

                VStack{
                    HStack{
                        Spacer()

                        Image("ItunesArtwork")

                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 22, height: 22, alignment: .center)
                            .foregroundColor(.white)
                            .cornerRadius(4)
                            .clipped()

                    }
                    .padding(10)
                    Image("qr-code")

                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .foregroundColor(.white)

                    Text("Link Device").foregroundColor(.white)
                        .font(Font.custom("DroidKufi-Regular", size: 14))
                    Spacer()
                }

            }.widgetURL(URL(string: "widget-deeplink://")!)
        
        }
       
    }
}

@main
struct LockScreenWidget: Widget {
    let kind: String = "LockScreenWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            LockScreenWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Almanbr QRCode Scanner")
        .description("This widget scan qrcode from web.")
        .supportedFamilies([.systemSmall,.systemMedium,.accessoryCircular])
        
    }
}

struct LockScreenWidget_Previews: PreviewProvider {
    static var previews: some View {
        LockScreenWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
