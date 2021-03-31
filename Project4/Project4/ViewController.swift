//
//  ViewController.swift
//  Project4
//
//  Created by 이지원 on 2021/03/31.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var progressView: UIProgressView!

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(openTapped))

        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                     target: nil,
                                     action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh,
                                      target: webView,
                                      action: #selector(webView.reload))

        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false

        let url = URL(string: "https://google.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true

        webView.addObserver(self,
                            forKeyPath: #keyPath(WKWebView.estimatedProgress),
                            options: .new,
                            context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

    @objc func openTapped() {
        let alertController = UIAlertController(title: "Open page...",
                                                message: nil,
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "apple.com",
                                                style: .default,
                                                handler: openPage))
        alertController.addAction(UIAlertAction(title: "google.com",
                                                style: .default,
                                                handler: openPage))
        alertController.addAction(UIAlertAction(title: "Cancle",
                                                style: .cancel))
        alertController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(alertController, animated: true)
    }

    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}
