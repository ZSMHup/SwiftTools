//
//  TYSLikelyPeopleCollectionViewCell.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/22.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSLikelyPeopleCollectionViewCell: UICollectionViewCell {
    var interestedPeoArr: [TYSInterestedPeopleModel] = [TYSInterestedPeopleModel]()
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
        tempCollectionView.register(TYSCommonLikelyPeoCollectionViewCell.self, forCellWithReuseIdentifier: "TYSCommonLikelyPeoCollectionViewCell")
        return tempCollectionView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInterestedPeoArray(interestedPeoArray: [TYSInterestedPeopleModel]) {
        interestedPeoArr = interestedPeoArray
        collectionView.reloadData()
    }
}

extension TYSLikelyPeopleCollectionViewCell {
    private func addSubViews() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
}

extension TYSLikelyPeopleCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(0, AdaptW(w: 24), 0, AdaptW(w: 24))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return interestedPeoArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TYSCommonLikelyPeoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TYSCommonLikelyPeoCollectionViewCell", for: indexPath) as! TYSCommonLikelyPeoCollectionViewCell
        
        cell.setModel(model: interestedPeoArr[indexPath.item])
        
        return cell
    }
}
