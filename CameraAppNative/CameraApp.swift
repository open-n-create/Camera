import SwiftUI
import WebKit
import AVFoundation
import Photos

@main
struct CameraApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        WebViewContainer()
            .edgesIgnoringSafeArea(.all)
            .statusBar(hidden: true)
            .onAppear {
                AVCaptureDevice.requestAccess(for: .video) { _ in }
                AVCaptureDevice.requestAccess(for: .audio) { _ in }
                PHPhotoLibrary.requestAuthorization { _ in }
            }
    }
}

struct WebViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        
        let webView = WKWebView(frame: .zero, configuration: config)
        if let htmlPath = Bundle.main.path(forResource: "index", ofType: "html") {
            let htmlUrl = URL(fileURLWithPath: htmlPath)
            webView.loadFileURL(htmlUrl, allowingReadAccessTo: htmlUrl.deletingLastPathComponent())
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
