//
//  ContentView.swift
//  BrainTrainingGame
//
//  Created by Alessandre Livramento on 03/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var randonChoice = 0
    @State private var countScore = 0
    @State private var countQuestion = 0
    @State private var message = "Vamos Jogar"
    @State private var isAlert = false
    @State var itenSelect = -1
    
    var moves = ["rock", "paper", "scissors"]
    let images = [ "✊", "✋", "✌️"]
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack {
                TopView()
                
                VStack {
                    Text("Sua escolha")
                        .font(.system(size: 20).bold())
                        .foregroundStyle(Color("Background 8"))
                        .padding(.bottom, 0)
                    
                    HStack(spacing: 20) {
                        ForEach(0..<images.count, id: \.self){ number in
                            Button {
                                withAnimation(.easeIn(duration: 0.3)) {
                                    choice(number)
                                    itenSelect = number
                                }
                    
                            } label: {
                                ItensView(images: images, number: number, itenSelect: itenSelect)
                                
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                   
                
                    RandowView(images: images, randonChoice: randonChoice)
                    
                    MessageView(message: message)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                
                ScoreView(countScore: countScore)
                
            }
            .padding()
            .alert("Fim de Jogo", isPresented: $isAlert) {
                Button("Reinicie o Jogo", action: reset)
            } message: {
                Text("Sua pontuação é \(countScore)")
            }
        }
    }
    
    public func choice(_ number: Int) {
        randonChoice = Int.random(in: 0...2)
        
        if moves[randonChoice] ==  moves[number] {
            message = "Empate não pontua"
        }
        
        if moves[randonChoice] == "rock" && moves[number] == "paper" {
            countScore += 1
            message = "Ganhou"
        }
        
        if moves[randonChoice] == "rock" && moves[number] == "scissors" {
            countScore -= 1
            message = "Perdeu"
        }
        
        if moves[randonChoice] == "paper" && moves[number] == "rock" {
            countScore -= 1
            message = "Perdeu"
        }
        
        if moves[randonChoice] == "paper" && moves[number] == "scissors" {
            countScore += 1
            message = "Ganhou"
        }
        
        if moves[randonChoice] == "scissors" && moves[number] == "rock" {
            countScore += 1
            message = "Ganhou"
        }
        
        if moves[randonChoice] == "scissors" && moves[number] == "paper" {
            countScore -= 1
            message = "Perdeu"
        }
        
        countQuestion += 1
        
        if countQuestion == 10 {
            isAlert.toggle()
        }
    }
    
    public func reset() {
        randonChoice = 0
        countScore = 0
        countQuestion = 0
        itenSelect = -1
        message = "Vamos Jogar"
    }
}

struct TopView: View {
    var body: some View {
        Spacer()
        
        Text ("Jogo")
            .font(.largeTitle.bold())
            .foregroundColor(.white)
        
        Text("Pedra, papel e tesoura")
            .font(.largeTitle.bold())
            .foregroundColor(.white)
        
    }
}

struct ItensView: View {
    var images: [String]
    var number: Int
    var itenSelect: Int
    
    var body: some View {
        VStack {
            Text(images[number])
                .font(.system(size: 50))
                .frame(width: 80, height: 80)
                .background(Circle().fill(Color.moves))
                .shadow(radius: 5)
                .background(Circle().stroke(Color.itens, lineWidth: number == itenSelect ? 9 : 0))

        }
    }
}

struct RandowView: View {
    var images: [String]
    var randonChoice: Int
    
    var body: some View {
        VStack {
            Text(images[randonChoice])
                .font(.system(size: 200))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Circle().fill(Color.moves))
        .shadow(radius: 5)
    }
}

struct MessageView: View {
    var message: String
    
    var body: some View {
        VStack {
            Text(message)
                .font(.system(size: 36).bold())
                .foregroundStyle(Color("Background 8"))
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ScoreView: View {
    var countScore: Int
    
    var body: some View {
        Text("Pontuação: \(countScore)")
            .font(.title.bold())
            .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
