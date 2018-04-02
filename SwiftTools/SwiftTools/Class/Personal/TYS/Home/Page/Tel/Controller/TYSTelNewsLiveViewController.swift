//
//  TYSTelNewsLiveViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/30.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import MJRefresh

class TYSTelNewsLiveViewController: BaseViewController {

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: AdaptW(w: 158), height: AdaptH(h: 215))
        let tempCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        tempCollectionView.delegate = self
        tempCollectionView.dataSource = self
        tempCollectionView.backgroundColor = tys_whiteColor
        tempCollectionView.showsVerticalScrollIndicator = false
        tempCollectionView.showsHorizontalScrollIndicator = false
        tempCollectionView.register(TYSCommonCollectionViewCell.self, forCellWithReuseIdentifier: "TYSCommonCollectionViewCell")
        return tempCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
    }



}

extension TYSTelNewsLiveViewController {
    private func addSubViews() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(-kNavigationBarHeight)
        }
        
        collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                self?.collectionView.mj_header.endRefreshing()
            })
        })
        
        collectionView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {[weak self] in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                self?.collectionView.mj_footer.endRefreshing()
            })
        })
        
        collectionView.mj_header.beginRefreshing()
    }
}

// MARK: delegate
extension TYSTelNewsLiveViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(AdaptH(h: 24), AdaptW(w: 24), 0, AdaptW(w: 24))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TYSCommonCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TYSCommonCollectionViewCell", for: indexPath) as! TYSCommonCollectionViewCell
        //        let hotModel = hotArr[indexPath.item]
        //        cell.setModel(model: hotModel)
        return cell
    }
    
}
