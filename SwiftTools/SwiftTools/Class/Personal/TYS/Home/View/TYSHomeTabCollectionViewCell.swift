//
//  TYSHomeTabCollectionViewCell.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/22.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

typealias itemClickBlock = (Int) -> Void

class TYSHomeTabCollectionViewCell: UICollectionViewCell {
    
    var didSelectedItemClick: itemClickBlock?
    
    
    private var tabDataSource = [Dictionary<String, Any>]()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: kScreenW/4, height: AdaptH(h: 75))
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let tempCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        tempCollectionView.delegate = self
        tempCollectionView.dataSource = self
        tempCollectionView.backgroundColor = tys_whiteColor
        tempCollectionView.showsVerticalScrollIndicator = false
        tempCollectionView.showsHorizontalScrollIndicator = false
        tempCollectionView.register(TYSHomeTabCell.self, forCellWithReuseIdentifier: "TYSHomeTabCell")
        return tempCollectionView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTabArray(tabArray: [Dictionary<String, Any>]) {
        tabDataSource = tabArray
    }
    
    func didSelectedItemAction(tempClick: @escaping itemClickBlock) {
        didSelectedItemClick = tempClick
    }
}

extension TYSHomeTabCollectionViewCell {
    private func addSubViews() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
}

extension TYSHomeTabCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tabDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TYSHomeTabCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TYSHomeTabCell", for: indexPath) as! TYSHomeTabCell
        cell.setTabConfig(tabDataSource: tabDataSource[indexPath.item] as! [String : String])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if didSelectedItemClick != nil {
            didSelectedItemClick!(indexPath.item)
        }
    }
}

