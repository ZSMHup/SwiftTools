//
//  TYSConnectionAnalystCell.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/4/3.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

class TYSConnectionAnalystCell: UITableViewCell {

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: AdaptW(w: 54), height: AdaptH(h: 100))
        layout.scrollDirection = .horizontal
        let tempCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        tempCollectionView.delegate = self
        tempCollectionView.dataSource = self
        tempCollectionView.backgroundColor = tys_whiteColor
        tempCollectionView.showsVerticalScrollIndicator = false
        tempCollectionView.showsHorizontalScrollIndicator = false
        tempCollectionView.register(TYSConnectionAnalystCollectionCell.self, forCellWithReuseIdentifier: "TYSConnectionAnalystCollectionCell")
        return tempCollectionView
        
    }()
    
    var analystArr: [TYSInterestedPeopleModel] = [TYSInterestedPeopleModel]()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
    
    func setAnalystArray(analystArr: [TYSInterestedPeopleModel]) {
        self.analystArr = analystArr
        collectionView.reloadData()
    }
    
}

extension TYSConnectionAnalystCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(0, AdaptW(w: 24), 0, AdaptW(w: 24))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return analystArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TYSConnectionAnalystCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TYSConnectionAnalystCollectionCell", for: indexPath) as! TYSConnectionAnalystCollectionCell
        
        cell.setModel(model: analystArr[indexPath.item])
        return cell
    }
}

