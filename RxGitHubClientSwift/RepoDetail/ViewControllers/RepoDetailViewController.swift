//
//  RepoDetailViewController.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa

class RepoDetailViewController: UIViewController {
    
    private let rootView: RepoDetailView
    private let webView: WKWebView
    
    private let viewModel: RepoDetailViewModelType
    private let disposeBag = DisposeBag()
    
    init(viewModel: RepoDetailViewModelType) {
        self.rootView = RepoDetailView()
        self.webView = WKWebView()
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func loadView() {
        self.view = self.rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - setup WKWebView
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.rootView.containerView.addSubview(webView)
        AutoLayout.fill(self.rootView.containerView, with: webView)
        self.rootView.containerView.bringSubview(toFront: self.rootView.progressBar)
        
        // MARK: - Inputs
        self.webView.rx.url
            .asSignal(onErrorJustReturn: nil)
            .emit(to: self.viewModel.inputs.urlChanged)
            .disposed(by: disposeBag)
        
        self.webView.rx.canGoBack
            .asDriver(onErrorJustReturn: false)
            .drive(self.viewModel.inputs.canGoBackState)
            .disposed(by: disposeBag)
        
        self.webView.rx.canGoForward
            .asDriver(onErrorJustReturn: false)
            .drive(self.viewModel.inputs.canGoForwardState)
            .disposed(by: disposeBag)
        
        self.rootView.backButton.rx.tap
            .asSignal()
            .emit(to: self.viewModel.inputs.backButtonTapped)
            .disposed(by: disposeBag)
        
        self.rootView.forwardButton.rx.tap
            .asSignal()
            .emit(to: self.viewModel.inputs.forwardButtonTapped)
            .disposed(by: disposeBag)
        
        self.rootView.refreshButton.rx.tap
            .asSignal()
            .emit(to: self.viewModel.inputs.refreshButtonTapped)
            .disposed(by: disposeBag)
        
        self.webView.rx.loading
            .asDriver(onErrorJustReturn: false)
            .drive(self.viewModel.inputs.isLoadingState)
            .disposed(by: disposeBag)
        
        self.webView.rx.estimatedProgress
            .asDriver(onErrorJustReturn: 0.0)
            .drive(self.viewModel.inputs.progressRateChanged)
            .disposed(by: disposeBag)
        
        // MARK: - Outputs
        // MARK: - Enable BarButtonItems
        self.viewModel.outputs.canGoBack
            .drive(self.rootView.backButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        self.viewModel.outputs.canGoForward
            .drive(self.rootView.forwardButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        // MARK: - BarButtonItems' Action
        self.viewModel.outputs.back
            .emit(onNext: { [weak self] _ in
                self?.rootView.errorMessage.isHidden = true
                self?.webView.goBack()
            }).disposed(by: disposeBag)
        
        self.viewModel.outputs.forward
            .emit(onNext: { [weak self] _ in
                self?.rootView.errorMessage.isHidden = true
                self?.webView.goForward()
            }).disposed(by: disposeBag)
        
        self.viewModel.outputs.refresh
            .emit(onNext: { [weak self] _ in
                self?.rootView.errorMessage.isHidden = true
                self?.webView.reload()
            }).disposed(by: disposeBag)
        
        // MARK: - ProgressView
        self.viewModel.outputs.isLoading
            .map { !$0 }
            .drive(self.rootView.progressBar.rx.isHidden)
            .disposed(by: disposeBag)
        
        self.viewModel.outputs.progressRateDidChange
            .drive(self.rootView.progressBar.rx.progress)
            .disposed(by: disposeBag)
        
        // MARK: - WebView
        self.viewModel.outputs.selectedRepoDidChange
            .filter { $0 != nil }
            .map { $0! }
            .drive(onNext: { [weak self] url in
                self?.webView.load(URLRequest(url: url))
            }).disposed(by: disposeBag)
        
        self.viewModel.outputs.selectedRepoDidChange
            .filter { $0 != nil }
            .map { _ in true }
            .drive(self.rootView.errorMessage.rx.isHidden)
            .disposed(by: disposeBag)
        
        self.viewModel.outputs.isUrlValid
            .filter { !$0 }
            .drive(onNext: { [weak self] bool in
                UIView.animate(withDuration: 0.25) {
                    self?.rootView.errorMessage.isHidden = bool
                }
            })
            .disposed(by: disposeBag)
        
        self.viewModel.outputs.urlDidChange
            .emit(onNext: { [weak self] _ in
                self?.rootView.errorMessage.isHidden = true
            }).disposed(by: disposeBag)
    }
}
