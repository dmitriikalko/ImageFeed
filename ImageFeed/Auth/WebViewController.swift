//
//  WebViewController.swift
//  ImageFeed
//
//  Created by Дмитрий Калько on 02.12.2023.
//

import Foundation
import UIKit
import WebKit

protocol WebViewViewControllerDelegate: AnyObject{
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewViewController)
}

final class WebViewViewController: UIViewController{
    
    //MARK: -IB Outlets
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var progressView: UIProgressView!
    
    //MARK: - privet properties
    private enum Constants {
        static let unsplashAuthorizeURLString: String = "https://unsplash.com/oauth/authorize"
    }
    //MARK: -Public Properties
    weak var delegate: WebViewViewControllerDelegate?
    
    //MARK: -Ovarride Metods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWebView()
        webView.navigationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        webView.addObserver(
            self,
            forKeyPath: #keyPath(WKWebView.estimatedProgress),
            options: .new,
            context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: nil)
    }
    
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?) {
            if keyPath == #keyPath(WKWebView.estimatedProgress) {
                updateProgress()
            } else {
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
        }
    
    //MARK: -Private Metods
    private func updateProgress() {
        progressView.progress = Float(webView.estimatedProgress)
        progressView.isHidden = fabs(webView.estimatedProgress - 1.0) <= 0.0001
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
        if let code = fetchCode(url: navigationAction.request.url) {
            delegate?.webViewViewController(self, didAuthenticateWithCode: code)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    private func fetchCode(url: URL?) -> String? {
        guard let url = url,
              let components = URLComponents(string: url.absoluteString),
              components.path == "/oauth/authorize/native",
              let codeItem = components.queryItems?.first(where: { $0.name == "code"})
        else {
            return nil
        }
        return codeItem.value
    }
}

private extension WebViewViewController {
    func loadWebView() {
        var urlComponents = URLComponents(string: Constants.unsplashAuthorizeURLString)
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: ApiConstants.accessKey),
            URLQueryItem(name: "redirect_uri", value: ApiConstants.redirectURI),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: ApiConstants.accessScope)
        ]
        if let url = urlComponents?.url{
            let request  = URLRequest(url: url)
            webView.load(request)
        }
    }
}
