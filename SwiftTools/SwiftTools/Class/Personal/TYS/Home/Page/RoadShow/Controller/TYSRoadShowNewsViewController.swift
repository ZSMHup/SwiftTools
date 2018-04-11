//
//  TYSRoadShowNewsViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/30.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import MJRefresh

class TYSRoadShowNewsViewController: BaseViewController {

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
    
    private var page: Int = 1
    private var dataSource = [TYSLiveCommonModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
    }
    
    private func requestLiveListData() {
        let param = [
            "requestCode" : "80003",
            "page" : String(describing: page),
            "limit" : "10",
            "user_id" : "36738",
            "q_t" : "2",
            "type" : "2",
            "state" : "4"
        ]
        requestLiveList(paramterDic: param, cacheCompletion: { (cacheValue) in
            if self.collectionView.mj_header.isRefreshing {
                if !cacheValue.isEmpty {
                    self.dataSource.removeAll()
                    self.dataSource = cacheValue
                    self.collectionView.reloadData()
                }
            }
        }, successCompletion: { (successValue) in
            if self.collectionView.mj_header.isRefreshing {
                self.collectionView.mj_header.endRefreshing()
                self.dataSource.removeAll()
            }
            
            if self.collectionView.mj_footer.isRefreshing {
                self.collectionView.mj_footer.endRefreshing()
            }
            self.dataSource.append(contentsOf: successValue)
            self.collectionView.reloadData()
            
        }) { (failure) in
            showFail(text: "网络异常")
            if self.collectionView.mj_header.isRefreshing {
                self.collectionView.mj_header.endRefreshing()
            }
            if self.collectionView.mj_footer.isRefreshing {
                self.collectionView.mj_footer.endRefreshing()
            }
        }
    }

}

extension TYSRoadShowNewsViewController {
    private func addSubViews() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(-kNavigationBarHeight)
        }
        
        collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.page = 1
            self?.requestLiveListData()
        })
        
        collectionView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {[weak self] in
            self?.page += 1
            self?.requestLiveListData()
        })
        
        collectionView.mj_header.beginRefreshing()
    }
}

// MARK: delegate
extension TYSRoadShowNewsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(AdaptH(h: 24), AdaptW(w: 24), 0, AdaptW(w: 24))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TYSCommonCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TYSCommonCollectionViewCell", for: indexPath) as! TYSCommonCollectionViewCell
        let model = dataSource[indexPath.item]
        cell.setModel(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        liveDetail(liveListModel: dataSource[indexPath.item])
    }
    
}
