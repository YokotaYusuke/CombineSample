import SwiftUI
import Combine

struct CombineSampleView: View {
    @StateObject var viewModel = CombineSampleViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.text)
            Button("テキスト変更") {
                viewModel.text = "ボタンが押されたよ"
            }
        }
        
    }
}

class CombineSampleViewModel: ObservableObject {
    @Published var text: String = "計測開始"
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Timer.publish(every: 3.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                self.text = "3秒経過しました"
            }
            .store(in: &cancellables)
    }
}

#Preview {
    CombineSampleView(viewModel: .init())
}
