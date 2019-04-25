//
//  ViewController.swift
//  WorkPlayground-Swift4
//
//  Created by Nakama on 25/04/19.
//  Copyright © 2019 Nakama. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupLayout()
    }

    private func setupLayout(){
        let containerView = UIView()
        self.view.addSubview(containerView)
        
        containerView.snp.makeConstraints { [weak self] (make) in
            guard let self = self else {return}
            
            make.height.lessThanOrEqualTo(150)
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
    private weak var header: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        let image = UIImage(named: "gradient-box")
        self.backgroundView = UIImageView(image: image)
        
        setupHeader()
        setupBody()
    }
    
    private func setupHeader(){
        let header = UIView()
        header.backgroundColor = .gray
        self.addSubview(header)
        self.header = header
        header.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualTo(0)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        let title = "Beli XXX"
        let titleLabel = UILabel()
        titleLabel.text = title
        header.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.leading.equalToSuperview()
            make.width.lessThanOrEqualToSuperview()
            make.height.lessThanOrEqualToSuperview()
        }
        
        let appLinkText = "Lihat Semua"
        let appLinkButton = UIButton(type: .custom)
        appLinkButton.setTitle(appLinkText, for: .normal)
        appLinkButton.setTitleColor(.green, for: .normal)
        appLinkButton.addTarget(self, action: #selector(printEvent), for: .touchUpInside)
        header.addSubview(appLinkButton)
        appLinkButton.snp.makeConstraints { (make) in
            make.top.trailing.equalToSuperview()
            make.width.lessThanOrEqualToSuperview()
            make.height.lessThanOrEqualToSuperview()
        }
    }
    @objc private func printEvent(){
        print("clicked")
    }
    
    private func setupBody(){
        let body = UIView()
        body.backgroundColor = .blue
        self.addSubview(body)
        body.snp.makeConstraints {[weak header = self.header] (make) in
            guard let header = header else {return}
            
            make.width.equalToSuperview()
            //#error("autolayout")
            make.height.equalTo(110)
            make.top.equalTo(header.snp.bottom)
            make.leading.equalToSuperview()
        }
        
        #warning("make this a stack view")
        let stackView = UIStackView()
        
        
        let item = NavigationWidgetItemView()
        body.addSubview(item)
        item.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualToSuperview()
            make.width.lessThanOrEqualToSuperview()
            make.top.leading.equalToSuperview()
        }
    }
}

class NavigationWidgetItemView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        self.backgroundColor = .green
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(111)
    }
    
    private func setupLayout(){
        let itemImage = UIImage(named: "item-image")
        let imageView = UIImageView(image: itemImage)
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            let length = 52
            make.height.equalTo(length)
            make.width.equalTo(length)
            make.top.centerX.equalToSuperview()
        }
        
        let itemName = "Telkomsel"
        let itemNameLabel = UILabel()
        itemNameLabel.backgroundColor = .purple
        itemNameLabel.text = itemName
        self.addSubview(itemNameLabel)
        itemNameLabel.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(0)
            make.width.lessThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(10)
        }
        
        let itemPriceText = "10000"
        let itemPriceLabel = UILabel()
        itemPriceLabel.text = itemPriceText
        self.addSubview(itemPriceLabel)
        itemPriceLabel.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(0)
            make.width.lessThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(itemNameLabel.snp.bottom)
        }
        
        
    }
}
