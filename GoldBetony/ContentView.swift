import SwiftUI

struct ContentView: View {
    @StateObject private var store = SportsStore.shared
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    var body: some View {
        if hasSeenOnboarding {
            WebGateRouter {
                FacadeTabView()
                    .environmentObject(store)
                    .task { await store.loadIfNeeded() }
            } webContent: { url in
                WebGateView(url: url)
                    .ignoresSafeArea()
            }
        } else {
            OnboardingView()
                .transition(.opacity)
        }
    }
}
