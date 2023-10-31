//
//  LanguageProcesseor.swift
//  NLDemo
//
//  Created by Ye Eun Choi on 2023/10/31.
//

import NaturalLanguage

class LanguageProcessor: ObservableObject {
    let tagger = NSLinguisticTagger(
        tagSchemes: [
            .tokenType,
            .language,
            .lexicalClass,
            .nameType,
            .lemma,
            .script
        ],
        options: 0
    )
    
    let options: NSLinguisticTagger.Options = [
        .omitPunctuation,
        .omitWhitespace,
        .joinNames
    ]
    
    // MARK: - Tokenization
    /// breaking up a piece of text into linguistic units or tokens.
    public func tokenizeText(for text: String) -> [String] {
        tagger.string = text
      
        let range = NSRange(
            location: 0,
            length: text.utf16.count
        )
        
        var result: [String] = []
      
        tagger.enumerateTags(
            in: range,
            unit: .word,
            scheme: .tokenType,
            options: options
        ) { tag, tokenRange, stop in
            let word = (text as NSString).substring(with: tokenRange)
            result.append(word)
        }
        
        return result
    }
    
    // MARK: - Lemmatization
    /// deducing a word's stem based on its morphological analysis.
    public func lemmatization(for text: String) -> [String] {
        tagger.string = text
       
        let range = NSRange(
            location: 0,
            length: text.utf16.count
        )
        
        var result: [String] = []
       
        tagger.enumerateTags(
            in: range,
            unit: .word,
            scheme: .lemma,
            options: options
        ) { tag, tokenRange, stop in
            if let lemma = tag?.rawValue {
                print(lemma)
                result.append(lemma)
            }
        }
        
        return result
    }
    
    // MARK: - Parts of Speech Tagging
    /// marking up individual words with their part of speech.
    func partsOfSpeech(for text: String) -> [String] {
        tagger.string = text
       
        let range = NSRange(
            location: 0,
            length: text.utf16.count
        )
        
        var result: [String] = []
       
        tagger.enumerateTags(
            in: range,
            unit: .word,
            scheme: .lexicalClass,
            options: options
        ) { tag, tokenRange, _ in
            if let tag = tag {
                _ = (text as NSString).substring(with: tokenRange)
                result.append(tag.rawValue)
            }
        }
        
        return result
    }
}
