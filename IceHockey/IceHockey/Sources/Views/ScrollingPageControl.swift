//
//  PageControl.swift
//  IceHockey
//
//  Created by  Buxlan on 9/12/21.
//

import UIKit

public protocol ScrollingPageControlDelegate: class {
    //    If delegate is nil or the implementation returns nil for a given dot, the default
    //    circle will be used. Returned views should react to having their tint color changed
    func viewForDot(at index: Int) -> UIView?
}

class ScrollingPageControl: UIView {
    
    open weak var delegate: ScrollingPageControlDelegate? {
        didSet {
            createViews()
        }
    }
    
    var numberOfPages: Int = 0 {
        didSet {
            guard numberOfPages != oldValue else { return }
            numberOfPages = max(0, numberOfPages)
            invalidateIntrinsicContentSize()
            dotViews = (0..<numberOfPages).map { _ in
                CircularView(frame: CGRect(origin: .zero,
                                           size: CGSize(width: dotSize, height: dotSize)))
            }
        }
    }
    
    var currentPage: Int = 0 {
        didSet {
            updateColors()
            if (0..<centerDots).contains(currentPage - pageOffset) {
                centerOffset = currentPage - pageOffset
            } else {
                pageOffset = currentPage - centerOffset
            }
        }
    }
    
    var dotColor: UIColor = Asset.other1.color
    var selectedColor: UIColor = Asset.other0.color
    
    var dotSize: CGFloat = 6 {
        didSet {
            dotSize = max(1, dotSize)
            dotViews.forEach {
                $0.frame = CGRect(origin: .zero,
                                  size: CGSize(width: dotSize, height: dotSize))
            }
            updatePositions()
        }
    }
    var spacing: CGFloat = 4 {
        didSet {
            spacing = max(1, spacing)
            updatePositions()
        }
    }
    
    open var slideDuration: TimeInterval = 0.15
    private var centerOffset = 0
    private var pageOffset = 0 {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
                guard let self = self else { return }
                UIView.animate(withDuration: self.slideDuration,
                               delay: 0.15,
                               options: [],
                               animations: self.updatePositions,
                               completion: nil)
            }
        }
    }
    
    private var dotViews: [UIView] = [] {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            dotViews.forEach(addSubview)
            updateColors()
            updatePositions()
        }
    }
    
    var maxDots = 5 {
        didSet {
            if maxDots % 2 == 0 {
                maxDots += 1
                print("maxPages has to be an odd number")
            }
            invalidateIntrinsicContentSize()
            updatePositions()
        }
    }
    var centerDots = 3 {
        didSet {
            if centerDots % 2 == 0 {
                centerDots += 1
                print("centerDots has to be an odd number")
            }
            updatePositions()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let pages = min(maxDots, self.numberOfPages)
        let width = CGFloat(pages) * dotSize + CGFloat(pages - 1) * spacing
        let height = dotSize
        return CGSize(width: width, height: height)
    }
    
    init() {
        super.init(frame: .zero)
        isOpaque = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func draw(_ rect: CGRect) {
//        let horizontalOffset = CGFloat(-pageOffset + 2) * (dotSize + spacing) + (rect.width - intrinsicContentSize.width) / 2
//        let centerPage = 1 + pageOffset
//        (0..<pages).forEach { page in
//            (page == selectedPage ? selectedColor : dotColor).setFill()
//            let center = CGPoint(x: horizontalOffset + rect.minX + dotSize / 2 + (dotSize + spacing) * CGFloat(page), y: rect.midY)
//            var scale: CGFloat {
//                let distance = abs(page - (1 + pageOffset))
//                switch distance {
//                case 0, 1: return 1
//                case 2: return 0.66
//                case 3: return 0.33
//                case _: return 0
//                }
//            }
//            let size: CGSize = CGSize(side: dotSize * scale)
//            let rect = CGRect(center: center, size: size)
//            UIBezierPath(ovalIn: rect).fill()
//        }
//    }
    
    private var lastSize = CGSize.zero
    open override func layoutSubviews() {
        super.layoutSubviews()
        guard bounds.size != lastSize else { return }
        lastSize = bounds.size
        updatePositions()
    }
    
    private func createViews() {
        dotViews = (0..<numberOfPages).map { index in
            let size = CGSize(width: dotSize, height: dotSize)
            return delegate?.viewForDot(at: index) ?? CircularView(frame: CGRect(origin: .zero,
                                                                          size: size))
        }
    }
    
    private func updateColors() {
        dotViews.enumerated().forEach { page, dot in
            dot.tintColor = page == currentPage ? selectedColor : dotColor
        }
    }
    
    private func updatePositions() {
        let sidePages = (maxDots - centerDots) / 2
        let horizontalOffset = CGFloat(-pageOffset + sidePages) * (dotSize + spacing) + (bounds.width - intrinsicContentSize.width) / 2
        let centerPage = centerDots / 2 + pageOffset
        dotViews.enumerated().forEach { page, dot in
            let center = CGPoint(x: horizontalOffset + bounds.minX + dotSize / 2 + (dotSize + spacing) * CGFloat(page), y: bounds.midY)
            let scale: CGFloat = {
                let distance = abs(page - centerPage)
                if distance > (maxDots / 2) { return 0 }
                return [1, 0.66, 0.33, 0.16][max(0, min(3, distance - centerDots / 2))]
            }()
            dot.frame = CGRect(origin: .zero, size: CGSize(width: dotSize * scale, height: dotSize * scale))
            dot.center = center
        }
    }
    
}
