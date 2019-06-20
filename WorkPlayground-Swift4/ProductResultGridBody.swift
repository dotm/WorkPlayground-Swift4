//
//  ProductResultGridBody.swift
//  WorkPlayground-Swift4
//
//  Created by Yoshua Elmaryono on 20/06/19.
//  Copyright © 2019 Nakama. All rights reserved.
//

import AsyncDisplayKit

internal class ProductResultGridBody: ASDisplayNode {
    private let titleNode = ASTextNode()
    private let priceRowNode = ProductResultGridPriceNode()
    private let shopDataRowNode = ProductResultGridShopDataNode(location: "Jakarta", isOfficial: false, isPowerBadge: true)
    private let credibilityRowNode = ProductResultGridCredibilityRowNode(productRating: 4, productCountReview: 23, labels: ["Terbaru"])
    private let footerLabelsRowNode = FooterLabelsRowNode(offers: ["Pre-Order","Tukar Tambah"])
    
    internal override init() {
        super.init()
        automaticallyManagesSubnodes = true
        
        self.backgroundColor = .white
        titleNode.maximumNumberOfLines = 2
    }
    
    internal override func didLoad() {
        super.didLoad()
        bind()
    }
    
    private func bind(){
        titleNode.attributedText = NSAttributedString(string: "Two Line Product Name Placeholder")
    }
    
    internal override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let children: [ASDisplayNode] = [
            titleNode,
            priceRowNode,
            shopDataRowNode,
            credibilityRowNode,
            footerLabelsRowNode
        ]
        let stack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 3,
            justifyContent: .spaceBetween,
            alignItems: .start,
            children: children
        )
        
        let padding = CGFloat(8)
        let insets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        return ASInsetLayoutSpec(insets: insets, child: stack)
    }
}

fileprivate class ProductResultGridPriceNode: ASDisplayNode {
    private let originalPriceNode = ASTextNode()
    private let percentDiscountNode = ColoredLabel(text: "20%", backgroundColor: .red, textColor: .white)
    private let finalPriceNode = ASTextNode()
    
    internal override init() {
        super.init()
        automaticallyManagesSubnodes = true
        
        originalPriceNode.attributedText = NSAttributedString(string: "Rp.100.000,-")
        finalPriceNode.attributedText = NSAttributedString(string: "Rp.80.000,-")
    }
    
    internal override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let slashedPriceStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 5,
            justifyContent: .spaceBetween,
            alignItems: .center,
            children: [percentDiscountNode,originalPriceNode]
        )
        
        let stack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 0,
            justifyContent: .spaceBetween,
            alignItems: .start,
            children: [slashedPriceStack,finalPriceNode]
        )
        return stack
    }
}

fileprivate class ProductResultGridShopDataNode: ASDisplayNode {
    private var badgeIcon: ASImageNode? = nil
    private let shopLocation = ASTextNode()
    
    internal init(location: String, isOfficial: Bool, isPowerBadge: Bool) {
        super.init()
        automaticallyManagesSubnodes = true
        
        shopLocation.attributedText = NSAttributedString(string: location)
        
        if isOfficial || isPowerBadge {
            badgeIcon = ASImageNode()
            badgeIcon?.style.preferredSize = CGSize(width: 14, height: 14)
        }
        if isOfficial {
            badgeIcon?.image = UIImage(named: "official-store")
        } else if isPowerBadge {
            badgeIcon?.image = UIImage(named: "crown")
        }
    }
    
    internal override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var children: [ASDisplayNode] = [shopLocation]
        if let shopIcon = badgeIcon {
            children.insert(shopIcon, at: 0)
        }
        let stack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 5,
            justifyContent: .start,
            alignItems: .center,
            children: children
        )
        return stack
    }
}

fileprivate class ProductResultGridCredibilityRowNode: ASDisplayNode {
    private var children: [ASDisplayNode] = []
    
    internal init(productRating: Int, productCountReview: Int, labels: [String]) {
        super.init()
        automaticallyManagesSubnodes = true
        
        labels.forEach({ labelText in
            children.append(ColoredLabel(text: labelText, backgroundColor: .cyan, textColor: .blue))
        })
        
        if productCountReview > 0{
            children.append(ProductRatingNode(productRating: productRating, productCountReview: productCountReview))
        }
    }
    
    internal override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 3,
            justifyContent: .start,
            alignItems: .start,
            children: children
        )
        return stack
    }
}

fileprivate class ProductRatingNode: ASDisplayNode {
    private var stars: [ASImageNode]!
    private let reviewCountNode = ASTextNode()
    internal init(productRating: Int, productCountReview: Int) {
        super.init()
        automaticallyManagesSubnodes = true
        stars = createStarsRating(productRating: productRating, maxRating: 5)
        
        reviewCountNode.attributedText = NSAttributedString(string: "(\(productCountReview))")
    }
    
    private func createStarsRating(productRating: Int, maxRating: Int) -> [ASImageNode] {
        var stars: [ASImageNode] = []
        for i in 0..<maxRating{
            let starImage = ASImageNode()
            starImage.style.preferredSize = CGSize(width: 10, height: 10)
            starImage.image = i < productRating ? UIImage(named: "bright-star") : UIImage(named: "dark-star")
            
            stars.append(starImage)
        }
        return stars
    }
    
    internal override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let starsStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 2,
            justifyContent: .start,
            alignItems: .center,
            children: stars
        )
        let stack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 5,
            justifyContent: .start,
            alignItems: .center,
            children: [starsStack,reviewCountNode]
        )
        return stack
    }
}

fileprivate class FooterLabelsRowNode: ASDisplayNode {
    private var offersNode: OffersGroupNode!
    private let topAdsLabel = ASTextNode()
    
    internal init(offers: [String]) {
        super.init()
        automaticallyManagesSubnodes = true
        
        offersNode = OffersGroupNode(offers: offers)
        topAdsLabel.attributedText = NSAttributedString(string: "Top Ads")
    }
    internal override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let spacing = CGFloat(3)
        let topAdsWidth = CGFloat(30)
        topAdsLabel.style.maxWidth = ASDimension(unit: .points, value: topAdsWidth)
        offersNode.style.width = ASDimension(unit: .points, value: constrainedSize.max.width - spacing - topAdsWidth)
        offersNode.backgroundColor = .yellow
        let stack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: spacing,
            justifyContent: .spaceBetween,
            alignItems: .start,
            children: [offersNode,topAdsLabel]
        )
        return stack
    }
}

fileprivate class OffersGroupNode: ASDisplayNode {
    private var children: [ASDisplayNode] = []
    
    internal init(offers: [String]) {
        super.init()
        automaticallyManagesSubnodes = true
        
        offers.forEach({ offerText in
            children.append(ColoredLabel(text: offerText, backgroundColor: .gray, textColor: .black))
        })
    }
    
    internal override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 5,
            justifyContent: .start,
            alignItems: .center,
            children: children
        )
        stack.flexWrap = .wrap
        stack.lineSpacing = CGFloat(3)
        return stack
    }
}
