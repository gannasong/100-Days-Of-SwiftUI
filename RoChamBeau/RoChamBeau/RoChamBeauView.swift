//
//  RoChamBeauView.swift
//  RoChamBeau
//
//  Created by SUNG HAO LIN on 2022/8/4.
//

import SwiftUI

struct RoChamBeauView: View {
    enum Mora: String {
        case rock
        case paper
        case scissors
        case none
    }
    
    enum WinOrLose: String {
        case win
        case lose
    }
    
    @State var showingScore = false
    @State var showingReset = false
    @State private var scoreTitle = ""
    @State private var aleretMessage = ""
    
    @State var moras: [Mora] = [.rock, .paper, .scissors]
    @State var npcWinOrLoses: [WinOrLose] = [.win, .lose]
    
    @State var npcSelectedMora: Mora = .rock
    @State var npcWinOrLose: WinOrLose = .win
    
    @State var userSelectedMora: Mora = .none
    
    @State var playCount: Int = 0
    @State var score: Int = 0
    var maxCount: Int = 8
    
    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(colors: [.red, .blue, .orange, .green, .cyan, .primary], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                .zIndex(0)
            
            VStack(spacing: 50) {
                Text("NPC:")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top, 70)
                
                Image(npcSelectedMora.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                
                Text("Choose to \(npcWinOrLose.rawValue)")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                HStack(spacing: 20) {
                    ForEach(moras, id: \.self) { mora in
                        Button {
                            userSelectedMora = mora
                        } label: {
                            Image(mora.rawValue)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .background(
                                    Circle()
                                        .fill(userSelectedMora == mora ? Color.red : Color.purple)
                                        .frame(width: 80, height: 80, alignment: .center)
                                        .offset(y: 25)
                                )
                                .opacity(userSelectedMora == mora ? 1 : 0.5)
                        }
                    }
                }
                
                Button {
                    doRoChamBeau()
                } label: {
                    Text("Shoot!")
                        .padding()
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .background(Color.purple)
                        .cornerRadius(8)
                        .opacity(userSelectedMora == .none ? 0.5 : 1)
                }
                .disabled(userSelectedMora == .none)
                
                HStack(spacing: 50) {
                    Text("\(playCount) / \(maxCount)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    Text("score: \(score)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
        }
        .onAppear {
            npcSelectedMora = moras.randomElement() ?? .rock
            npcWinOrLose = npcWinOrLoses.randomElement() ?? .win
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button {
                continueGame()
            } label: {
                Text("Continue")
            }
        } message: {
            Text(aleretMessage)
        }
        .alert("Game Over", isPresented: $showingReset) {
            Button {
                reset()
            } label: {
                Text("Reset")
            }
        } message: {
            Text("Your score is \(score) 🫡🫡🫡🫡🫡🫡!")
        }
    }
    
    private func reset() {
        userSelectedMora = .none
        npcSelectedMora = moras.randomElement() ?? .rock
        npcWinOrLose = npcWinOrLoses.randomElement() ?? .win
        score = 0
        playCount = 0
    }
    
    private func continueGame() {
        userSelectedMora = .none
        npcSelectedMora = moras.randomElement() ?? .rock
        npcWinOrLose = npcWinOrLoses.randomElement() ?? .win
    }
    
    private func doRoChamBeau() {
        playCount += 1
        // 對答案
        switch npcWinOrLose {
        case .win:
            // 需要贏
            switch (npcSelectedMora, userSelectedMora) {
            case (.rock, .paper), (.paper, .scissors), (.scissors, .rock):
                score += 1
                scoreTitle = "Correct"
                aleretMessage = "Good job 🫡"
            default:
                score = max(0, score - 1)
                scoreTitle = "Sorry"
                aleretMessage = "Try again 😱"
            }
        case .lose:
            // 需要輸
            switch (npcSelectedMora, userSelectedMora) {
            case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
                score += 1
                scoreTitle = "Correct"
                aleretMessage = "Good job 🫡"
            default:
                score = max(0, score - 1)
                scoreTitle = "Sorry"
                aleretMessage = "Try again 😱"
            }
        }
        
        if playCount == maxCount {
            showingReset = true
        } else {
            showingScore = true
        }
    }
}

struct RoChamBeauView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
