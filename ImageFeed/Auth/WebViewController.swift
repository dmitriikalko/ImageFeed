//
//  WebViewController.swift
//  ImageFeed
//
//  Created by Дмитрий Калько on 02.12.2023.
//

import Foundation
import UIKit
import WebKit

fileprivate let UnsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"

protocol WebViewViewControllerDelegate: AnyObject{
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewViewController)
}


final class WebViewViewController: UIViewController{
    
    //MARK: -IB Outlets
    @IBOutlet private weak var webView: WKWebView!
    
    //MARK: -Public Properties
    weak var delegate: WebViewViewControllerDelegate?
    
    //MARK: -Ovarride Metods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents(string: UnsplashAuthorizeURLString)!  //1
        urlComponents.queryItems = [
           URLQueryItem(name: "client_id", value: AccessKey),                  //2
           URLQueryItem(name: "redirect_uri", value: RedirectURI),             //3
           URLQueryItem(name: "response_type", value: "code"),                 //4
           URLQueryItem(name: "scope", value: AccessScope)                     //5
         ]
         let url = urlComponents.url!                                            //6
        
        let request  = URLRequest(url: url)
        webView.load(request)
        
        webView.navigationDelegate = self
        
    }
    
    //MARK: -IB Actions
    @IBAction private func didTapBackButton(_ sender: Any?) {
        delegate?.webViewViewControllerDidCancel(self)
    }
}

//MARK: extension Deelegate

extension WebViewViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        if let code = code(from: navigationAction) {
            delegate?.webViewViewController(self, didAuthenticateWithCode: code)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    private func code(from navigationAction: WKNavigationAction) -> String? {
        if
            let url = navigationAction.request.url,
            let urlComponents = URLComponents(string: url.absoluteString),
            urlComponents.path == "/oauth/authorize/native",
            let items = urlComponents.queryItems,
            let codeItem = items.first(where: { $0.name == "code" })
        {
            return codeItem.value
        } else {
            return nil
        }
    }
}
