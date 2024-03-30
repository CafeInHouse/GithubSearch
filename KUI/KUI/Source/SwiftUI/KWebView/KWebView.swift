//
//  KWebView.swift
//  KUI
//
//  Created by saeng lin on 3/30/24.
//

import SwiftUI
import WebKit
 
public struct KWebView: UIViewRepresentable {

    private var url: URL?
    
    public init(url: URL?) {
        self.url = url
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        
        guard let url = url else {
            return WKWebView()
        }
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    //업데이트 ui view
    public func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<KWebView>) {
        
    }
}
 
//Canvas 미리보기용
struct MyWebView_Previews: PreviewProvider {
    static var previews: some View {
        KWebView(url: URL(string: "https://www.naver.com"))
    }
}
