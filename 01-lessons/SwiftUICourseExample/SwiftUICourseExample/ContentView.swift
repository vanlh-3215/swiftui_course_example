//
//  ContentView.swift
//  SwiftUICourseExample
//
//  Created by le.hong.van on 27/7/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("II.1 Declarative UI Mindset") {
                    NavigationLink("1.1 Imperative") {
                        MovieBookmarkUIKitView()
                            .navigationTitle("1.1 Imperative")
                    }
                    
                    NavigationLink("1.2 Declarative") {
                        MovieBookmarkView()
                            .navigationTitle("1.2 Declarative")
                    }
                    
                    NavigationLink("5.2 Bookmark Movie State") {
                        MovieDetailMindsetView()
                            .navigationTitle("5.2 Bookmark Movie State")
                    }
                }
                
                Section("II.2 App Lifecycle & Scene-based Architecture") {
                    NavigationLink("4.3 Timer Count") {
                        TicketTimerView()
                            .navigationTitle("4.3 Timer Count")
                    }
                }
                
                Section("II.3 Retain Cycle") {
                    NavigationLink("2.2 CineHub Retain Cycle") {
                        CineHubRetainCycleView()
                            .navigationTitle("2.2 CineHub Retain Cycle")
                    }
                    
                    NavigationLink("4.1 Retain Cycle In Closure") {
                        MovieListView()
                            .navigationTitle("4.1 Retain Cycle In Closure")
                    }
                }
                
                Section("III.1 SwiftUI Fundamentals") {
                    NavigationLink("8.2 MovieCardView Code Skeleton") {
                        MovieEventCardView()
                            .navigationTitle("8.2 MovieCardView")
                    }
                }
                
                Section("III.2 State Management") {
                    NavigationLink("2.3 State Hoisting Example") {
                        CineHubPaymentView()
                            .navigationTitle("2.3 State Hoisting")
                    }
                    
                    NavigationLink("6 Data System Of CineHub") {
                        CineHubStoreView()
                            .navigationTitle("6 Data System Of CineHub")
                    }
                }
                
                Section("III.3 Responsive") {
                    NavigationLink("1.2 Variable Color & Symbol Effects") {
                        MovieInteractionDemoView()
                            .navigationTitle("1.2 Symbol Effects")
                    }
                    
                    NavigationLink("4.2 CineHub Adaptive Ticket") {
                        CineAdaptiveTicketView(
                            movieTitle: "Dune: Hành Tinh Cát 2",
                            showTime: "20:00 - 24/12/2026",
                            ticketPrice: 120000
                        )
                        .navigationTitle("4.2 Adaptive Ticket")
                    }
                }
                
                Section("III.4 Clean Architecture") {
                    NavigationLink("6 CineHub Clean Architecture") {
                        CleanMovieDetailView()
                            .navigationTitle("6 Clean Architecture")
                    }
                }
            }
            .navigationTitle("SwiftUI Course")
        }
    }
}

struct MovieBookmarkUIKitView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MovieBookmarkViewController {
        MovieBookmarkViewController(nibName: "MovieBookmarkViewController", bundle: nil)
    }
    
    func updateUIViewController(_ uiViewController: MovieBookmarkViewController, context: Context) {}
}

#Preview {
    ContentView()
}
