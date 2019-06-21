//
//  ProductResultGridHeader.swift
//  
//
//  Created by Yoshua Elmaryono on 20/06/19.
//

import AsyncDisplayKit

internal class ProductResultGridHeader: ASDisplayNode {
    private let imageNode = ASNetworkImageNode()
    private let wishlistNode = WishListNode(isOnWishlist: true)
    private let promoLabelsNode = PromoLabelsNode(labels: ["Cashback 10%","Gratis Ongkir"])
    
    internal override init() {
        super.init()
        automaticallyManagesSubnodes = true
        imageNode.contentMode = .scaleAspectFit
        imageNode.forceUpscaling = true
        imageNode.url = URL(string: "https://via.placeholder.com/140")
    }
    
    internal override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let imageLength = constrainedSize.max.width
        imageNode.style.preferredSize = CGSize(width: imageLength, height: imageLength)
        
        let wishlistLength = CGFloat(28)
        wishlistNode.style.preferredSize = CGSize(width: wishlistLength, height: wishlistLength)
        
        let wishlistMargin = CGFloat(7)
        let wishlistInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: wishlistMargin, left: 0, bottom: 0, right: wishlistMargin), child: wishlistNode)
        let wishlistSpec = ASRelativeLayoutSpec(horizontalPosition: .end, verticalPosition: .start, sizingOption: .minimumSize, child: wishlistInset)
        let wishlistOverlay = ASOverlayLayoutSpec(child: imageNode, overlay: wishlistSpec)
        
        let promoLabelsSpec = ASRelativeLayoutSpec(horizontalPosition: .start, verticalPosition: .end, sizingOption: .minimumSize, child: promoLabelsNode)
        let overlay = ASOverlayLayoutSpec(child: wishlistOverlay, overlay: promoLabelsSpec)
        
        return overlay
    }
}

fileprivate class PromoLabelsNode: ASDisplayNode {
    private var promos: [ASDisplayNode] = []
    
    internal init(labels: [String]) {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .green
        
        labels.forEach { label in
            let node = ASTextNode()
            node.attributedText = NSAttributedString(string: label, attributes: [
                NSAttributedString.Key.foregroundColor : UIColor.black
                ])
            promos.append(node)
        }
    }
    
    override func layoutDidFinish() {
        super.layoutDidFinish()
        roundCorners(cornerRadius: 5)
    }
    
    private func roundCorners(cornerRadius: Double) {
        let path = UIBezierPath(roundedRect: self.view.bounds, byRoundingCorners: [.topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.view.bounds
        maskLayer.path = path.cgPath
        self.view.layer.mask = maskLayer
    }
    
    internal override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let padding = CGFloat(4)
        let stack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: padding,
            justifyContent: .start,
            alignItems: .start,
            children: promos
        )
        let insets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        return ASInsetLayoutSpec(insets: insets, child: stack)
    }
}

fileprivate class WishListNode: ASDisplayNode {
    private let imageNode = ASImageNode()
    
    internal init(isOnWishlist: Bool) {
        super.init()
        automaticallyManagesSubnodes = true
        
        if isOnWishlist {
            setImageOnWishlist()
        }else{
            setImageNotOnWishlist()
        }
    }
    
    private func setImageOnWishlist(){
        imageNode.image = UIImage(named: "full-heart")
    }
    private func setImageNotOnWishlist(){
        imageNode.image = UIImage(named: "empty-heart")
    }
    
    internal override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASWrapperLayoutSpec(layoutElement: imageNode)
    }
}
