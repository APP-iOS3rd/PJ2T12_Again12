//
//  BedgeView.swift
//  PJ2T12_Again12
//
//  Created by kwon ji won on 12/15/23.
//

import SwiftUI

struct BedgeView: View {
    
    @State private var todoBadges = ["FirstF", "Todo10F", "Wantto10F"]
    @State private var friendBadges = [ "FriendF", "AlertF", "FightingF" ]
    @State private var selectedbadge = ""
    @State var begdeSelect: Int = 0
    @State var showMedals = false
    
    @AppStorage("firstWantTodoIt") var firstWantTodoIt: Int = 2 
    @State var settingsDetent = PresentationDetent.medium
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            Button {
                selectedbadge = firstWantTodoIt > 0 ? "FirstT" : "FirstF"
                showMedals = true
                begdeSelect = 0
            } label: {
                Image(firstWantTodoIt > 0 ? "FirstT" : "FirstF")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75)
                    .padding(12)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke((Color.BorderBrown).opacity(0.32), lineWidth: 2)
                    }
            }
            Button {
                selectedbadge = firstWantTodoIt > 9 ? "Todo10T" : "Todo10F"
                showMedals = true
                begdeSelect = 1
            } label: {
                Image(firstWantTodoIt > 9 ? "Todo10T" : "Todo10F")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75)
                    .padding(12)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke((Color.BorderBrown).opacity(0.32), lineWidth: 2)
                    }
            }
            Button {
                selectedbadge = firstWantTodoIt > 9 ? "Wantto10T" : "Wantto10F"
                showMedals = true
                begdeSelect = 2
            } label: {
                Image(firstWantTodoIt > 9 ? "Wantto10T" : "Wantto10F")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75)
                    .padding(12)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke((Color.BorderBrown).opacity(0.32), lineWidth: 2)
                    }
            }
            ForEach(friendBadges, id: \.self) { badge in
                Button {
                    selectedbadge = badge
                    showMedals = true
                    begdeSelect = 3 + friendBadges.firstIndex(of: badge)!
                } label : {
                    Image(badge)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75)
                        .padding(12)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke((Color.BorderBrown).opacity(0.32), lineWidth: 2)
                        }
                }
            }
        }
        .sheet(isPresented: $showMedals) {
            StatusModalView(selectedBadge: $selectedbadge, begdeSelect: $begdeSelect)
                .presentationDetents( [.height(300), .large], selection: $settingsDetent)
        }
    }
}

#Preview {
    BedgeView()
}
