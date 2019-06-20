//
//  ViewController.swift
//  WorkPlayground-Swift4
//
//  Created by Nakama on 25/04/19.
//  Copyright © 2019 Nakama. All rights reserved.
//

import AsyncDisplayKit
import RxCocoa
import RxCocoa_Texture
import RxSwift
import NSObject_Rx
import SnapKit
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupLayout()
    }
    
    private func setupLayout(){
        view.backgroundColor = .black
        let containerView = UIView()
        self.view.addSubview(containerView)
        containerView.backgroundColor = .red
        
        containerView.snp.makeConstraints { [weak self] (make) in
            guard let self = self else {return}
            
            make.height.greaterThanOrEqualTo(200)
            make.centerY.equalToSuperview()
            let safeArea = self.view.safeAreaLayoutGuide.snp
            make.leading.equalTo(safeArea.leading)
            make.width.equalTo(view).dividedBy(2)
        }
        
        let cell = ProductResultGridCollectionViewCell()
        containerView.addSubview(cell)
        cell.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.greaterThanOrEqualToSuperview()
        }
    }
    
}

public class ProductResultGridCollectionViewCell: UICollectionViewCell {
    private let node = ProductResultGridNode()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubnode(node)
        
        let nodeView = node.view
        let parentView = contentView
        nodeView.translatesAutoresizingMaskIntoConstraints = false
        nodeView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        nodeView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
        nodeView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
        nodeView.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
    }
}

internal class ProductResultGridNode: ASDisplayNode {
    private let headerNode = ProductResultGridHeader()
    private let bodyNode = ProductResultGridBody()
    
    internal override init() {
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    internal override func didLoad() {
        self.backgroundColor = .blue
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapProduct)))
    }
    @objc func tapProduct(){
        print("kodok tapped")
    }
    
    internal override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let spacing = CGFloat(0)
        let stack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: spacing,
            justifyContent: .center,
            alignItems: .stretch,
            children: [headerNode, bodyNode]
        )
        let insets = UIEdgeInsets(top: spacing, left: 0.0, bottom: 0.0, right: 0.0)
        return ASInsetLayoutSpec(insets: insets, child: stack)
    }
}

internal class ColoredLabel: ASDisplayNode {
    private var textNode = ASTextNode()
    
    internal init(text: String, backgroundColor: UIColor, textColor: UIColor){
        super.init()
        automaticallyManagesSubnodes = true
        
        self.backgroundColor = backgroundColor
        self.cornerRadius = CGFloat(5)
        
        textNode.attributedText = NSAttributedString(string: text, attributes: [
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
            ])
    }
    
    internal override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let padding = CGFloat(3)
        let insets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        return ASInsetLayoutSpec(insets: insets, child: textNode)
    }
}
