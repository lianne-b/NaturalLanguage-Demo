//
//  ContentView.swift
//  NLDemo
//
//  Created by Ye Eun Choi on 2023/10/31.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var languageProcessor = LanguageProcessor()
    
    let textENG = "I Love Fast Cars"
    let textKOR = "안녕하세요, 이건 할 수 있나? 어떻게 해볼까. 아메리카노 한 잔 주세요."
    
    var body: some View {
        VStack {
            ForEach(
                languageProcessor
                    .partsOfSpeech(for: textENG),
                id:\.self
            ) { token in
                Text(token)
            }
        }
        .onAppear {
            print(languageProcessor
                .lemmatization(for: textKOR)
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
