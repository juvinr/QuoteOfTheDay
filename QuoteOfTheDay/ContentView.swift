//
//  ContentView.swift
//  QuoteOfTheDay
//
//  Created by Juvin R on 11/28/24.
//

import SwiftUI

struct ContentView: View {
    
    let gradient = LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.6), .black.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    let apiURL = "https://dummyjson.com/quotes/random"
    @State private var quote: Quote? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                gradient
                    .ignoresSafeArea()
                VStack(spacing: 50) {
                    VStack(alignment: .trailing, spacing: 16) {
                        if let quote = quote {
                            Text(quote.quote)
                            Text(" - \(quote.author)")
                                .fontWeight(.bold)
                        }
                    }
                    .font(.title3)
                    
                    Button {
                        fetchQuote()
                    } label: {
                        Text("Show me an another quote")
                            .foregroundStyle(.white)
                            .padding()
                            .background(.purple)
                            .clipShape(.buttonBorder)
                    }
        
                }
                .padding()
            }
            .navigationTitle("Quote of the Day")
            .onAppear {
                fetchQuote()
            }
        }
    }
    
    private func fetchQuote() {
        Task {
            do {
                let quoteOfTheDay: Quote = try await NetworkManager().fetch(from: apiURL)
                quote = quoteOfTheDay
            } catch {
                print("Error!", error.localizedDescription)
            }
        }
    }
}

#Preview {
    ContentView()
}
