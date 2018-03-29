//
//  AYPageMenu.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/29.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class AYPageMenu: UIView {
    
    var _items: [String]?
    var _selectedItemIndex: Int?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: AdaptW(w: 54), height: AdaptH(h: 80))
        layout.scrollDirection = .horizontal
        let tempCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        tempCollectionView.delegate = self
        tempCollectionView.dataSource = self
        tempCollectionView.backgroundColor = tys_whiteColor
        tempCollectionView.showsVerticalScrollIndicator = false
        tempCollectionView.showsHorizontalScrollIndicator = false
        tempCollectionView.register(AYPageMenuCell.self, forCellWithReuseIdentifier: "AYPageMenuCell")
        return tempCollectionView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func pageMenu(items: [String]) -> AYPageMenu {
        let pageMenu = AYPageMenu()
        pageMenu.frame = frame
        pageMenu.backgroundColor = UIColor.red
        pageMenu._items = items
        return pageMenu
    }

}

extension AYPageMenu {
    private func addSubViews() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

extension AYPageMenu: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(0, AdaptW(w: 24), 0, AdaptW(w: 24))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (_items?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AYPageMenuCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AYPageMenuCell", for: indexPath) as! AYPageMenuCell
       
        cell.setItems(item: _items![indexPath.item])
        return cell
    }
}
