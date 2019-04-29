//
//  ViewController.swift
//  WorkPlayground-Swift4
//
//  Created by Nakama on 25/04/19.
//  Copyright © 2019 Nakama. All rights reserved.
//

import UIKit
import SnapKit
import AsyncDisplayKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupLayout()
    }
    
    private func setupLayout(){
        let containerView = UIView()
        self.view.addSubview(containerView)
        containerView.backgroundColor = .red
        
        containerView.snp.makeConstraints { [weak self] (make) in
            guard let self = self else {return}
            
            make.height.greaterThanOrEqualTo(200)
            make.centerY.equalToSuperview()
            let safeArea = self.view.safeAreaLayoutGuide.snp
            make.leading.equalTo(safeArea.leading)
            make.trailing.equalTo(safeArea.trailing)
        }
        
        let cell = NavigationWidgetCell()
        containerView.addSubview(cell)
        cell.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.greaterThanOrEqualToSuperview()
        }
    }
    
}

class NavigationWidgetCell: UICollectionViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        let node = NavigationWidgetNode()
        contentView.addSubnode(node)
        node.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

class NavigationWidgetNode: ASDisplayNode {
    private let headerNode = NavigationWidgetHeader()
    private let bodyNode = NavigationWidgetBody()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        enableSubtreeRasterization()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 0,
            justifyContent: .spaceAround,
            alignItems: .stretch,
            children: [headerNode, bodyNode]
        )
    }
}

class NavigationWidgetHeader: ASDisplayNode {
    private let titleNode = ASTextNode()
    private let seeAllButtonNode = ASButtonNode()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        
        titleNode.attributedText = NSAttributedString(string: "Beli Pulsa", attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 24)
            ]
        )
        
        let buttonAttr = NSAttributedString(string: "Lihat Semua", attributes: [
            .foregroundColor: UIColor.green,
            .font: UIFont.systemFont(ofSize: 24)
            ]
        )
        seeAllButtonNode.setAttributedTitle(buttonAttr, for: .normal)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0,
            justifyContent: .spaceBetween,
            alignItems: .center,
            children: [titleNode, seeAllButtonNode]
        )
    }
}

class NavigationWidgetBody: ASDisplayNode {
    private var items: [NavigationWidgetItem] = []
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        
        items = [NavigationWidgetItem(), NavigationWidgetItem(), NavigationWidgetItem()]
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0,
            justifyContent: .spaceBetween,
            alignItems: .center,
            children: items
        )
    }
}

class NavigationWidgetItem: ASDisplayNode {
    private let imageNode = ASImageNode()
    private let titleNode = ASTextNode()
    private let subtitleNode = ASTextNode()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        
        imageNode.image = UIImage(named: "item-image")
        imageNode.contentMode = .scaleAspectFill
        
        titleNode.attributedText = NSAttributedString(string: "XL Axiata", attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16)
            ]
        )
        
        subtitleNode.attributedText = NSAttributedString(string: "20.000", attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 12)
            ]
        )
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        imageNode.style.width = ASDimension(unit: .points, value: 100)
        imageNode.style.height = imageNode.style.width
        
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 0,
            justifyContent: .start,
            alignItems: .center,
            children: [imageNode, titleNode, subtitleNode]
        )
    }
}
