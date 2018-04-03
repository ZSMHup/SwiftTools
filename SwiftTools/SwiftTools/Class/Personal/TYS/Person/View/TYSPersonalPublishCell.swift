//
//  TYSPersonalPublishCell.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/3.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSPersonalPublishCell: UITableViewCell {
    private var didSelectedItemClick: itemClickBlock?
    private var tabDataSource = [Dictionary<String, Any>]()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: (kScreenW - AdaptW(w: 88))/2, height: AdaptH(h: 30))
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let tempCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        tempCollectionView.delegate = self
        tempCollectionView.dataSource = self
        tempCollectionView.backgroundColor = tys_whiteColor
        tempCollectionView.showsVerticalScrollIndicator = false
        tempCollectionView.showsHorizontalScrollIndicator = false
        tempCollectionView.register(TYSPersonalPublishCollectionCell.self, forCellWithReuseIdentifier: "TYSPersonalPublishCollectionCell")
        return tempCollectionView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
extension TYSPersonalPublishCell {
    private func addSubViews() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
}

extension TYSPersonalPublishCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(AdaptH(h: 15), AdaptW(w: 24), 0, AdaptW(w: 24))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return AdaptW(w: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TYSPersonalPublishCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TYSPersonalPublishCollectionCell", for: indexPath) as! TYSPersonalPublishCollectionCell
        cell.setTabConfig(tabDataSource: tabDataSource[indexPath.item] as! [String : String])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if didSelectedItemClick != nil {
            didSelectedItemClick!(indexPath.item)
        }
    }
}

