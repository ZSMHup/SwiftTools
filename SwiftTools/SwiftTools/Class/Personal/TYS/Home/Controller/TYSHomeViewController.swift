//
//  TYSHomeViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/20.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

let kBannerHeight = kScreenW * 9 / 16

class TYSHomeViewController: BaseViewController {
    private var searchBtn: TYSSearchButton?
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let tempCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        tempCollectionView.contentInset = UIEdgeInsetsMake(kBannerHeight, 0, 0, 0)
        tempCollectionView.delegate = self
        tempCollectionView.dataSource = self
        tempCollectionView.backgroundColor = tys_whiteColor
        
        tempCollectionView.register(TYSHomeTabCollectionViewCell.self, forCellWithReuseIdentifier: "TYSHomeTabCollectionViewCell")
        tempCollectionView.register(TYSCommonCollectionViewCell.self, forCellWithReuseIdentifier: "TYSCommonCollectionViewCell")
        tempCollectionView.register(TYSHotCollectionViewCell.self, forCellWithReuseIdentifier: "TYSHotCollectionViewCell")
        tempCollectionView.register(TYSLikelyPeopleCollectionViewCell.self, forCellWithReuseIdentifier: "TYSLikelyPeopleCollectionViewCell")
        
        tempCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        return tempCollectionView
    }()
    private var cycleScrollView: WRCycleScrollView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: setupUI
extension TYSHomeViewController {
    
    private func setupUI() {
        setupNav()
        createCollectionView()
        createCycleScrollView()
    }
    
    private func setupNav() {
        navBarBackgroundAlpha = 0
        searchBtn = TYSSearchButton(title: "路演/电话会议/荐读分析师")
        searchBtn?.addTarget(self, action: #selector(searchBtnClick), for: .touchUpInside)
        
        let userImgView = UIView()
        userImgView.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: userImgView)
        
        let userImg = UIButton()
        userImg.frame = CGRect(x: 10, y: 0, width: 40, height: 40)
        userImg.setImage(UIImage(named: "defaut_avatar"), for: .normal)
        userImg.setImage(UIImage(named: "defaut_avatar"), for: .highlighted)
        userImg.layer.masksToBounds = true
        userImg.layer.cornerRadius = 20
        userImg.addTarget(self, action: #selector(personalCenter), for: .touchUpInside)
        userImgView.addSubview(userImg)
        
        let tipsView = UIView()
        tipsView.frame = CGRect(x: 44, y: 0, width: 6, height: 6)
        tipsView.backgroundColor = UIColor.red
        tipsView.layer.masksToBounds = true
        tipsView.layer.cornerRadius = 3
        userImgView.addSubview(tipsView)
    }
    
    private func createCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(view.snp.top).offset(-64.0)
        }
    }
    
    private func createCycleScrollView() {
        let height = kBannerHeight
        let frame = CGRect(x: 0, y: -height, width: kScreenW, height: height)
        let serverImages = ["http://p.lrlz.com/data/upload/mobile/special/s252/s252_05471521705899113.png",
                            "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007678060723.png",
                            "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007587372591.png",
                            "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007388249407.png",
                            "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007470310935.png"]
        cycleScrollView = WRCycleScrollView(frame: frame, type: .SERVER, imgs: serverImages, defaultDotImage: UIImage(named: "defaultDot"), currentDotImage: UIImage(named: "currentDot"), placeholderImage: UIImage(named: "defualt_banner"))
        cycleScrollView?.delegate = self
        collectionView.addSubview(cycleScrollView!)
        
    }
}

// MARK: event response
extension TYSHomeViewController {
    @objc private func personalCenter() {
        print("个人中心")
        navigationController?.pushViewController(TYSPersonalViewController(), animated: true)
    }
    
    @objc private func searchBtnClick() {
        print("首页搜索")
    }
}

// MARK: delegate
extension TYSHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, WRCycleScrollViewDelegate {
    
    //flow layout
    /**
     设置每一个itme的大小
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        if indexPath.section == 0 {
            
            return CGSize(width: kScreenW, height: AdaptH(h: 85))
            
        } else if indexPath.section == 1 {
            
            return CGSize(width: kScreenW, height: AdaptH(h: 90))
            
        } else if indexPath.section == 2 {
            
            return CGSize(width: kScreenW, height: AdaptH(h: 220))
            
        } else {
            
            return CGSize(width: AdaptW(w: 158), height: AdaptH(h: 210))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        if section == 3 {
            return UIEdgeInsetsMake(5, AdaptW(w: 24), 5, AdaptW(w: 24))
        }
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: 0, height: AdaptH(h: 0))
        }
        return CGSize(width: kScreenW, height: AdaptH(h: 60))
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 3 {
            return 6
        }
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TYSHomeTabCollectionViewCell", for: indexPath)
            return cell
            
        case 1:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TYSLikelyPeopleCollectionViewCell", for: indexPath)
            cell.backgroundColor = UIColor.red
            return cell
            
        case 2:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TYSHotCollectionViewCell", for: indexPath)
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TYSCommonCollectionViewCell", for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        var reusableview: UICollectionReusableView!
        
        if kind == UICollectionElementKindSectionHeader {
            
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath)
            
            for v in reusableview.subviews {
                v.removeFromSuperview()
            }
            
            var title: String?
            var image: String?
            
            
            if indexPath.section == 0 {
            } else if indexPath.section == 1 {
                title = "可能感兴趣的人"
                image = "default_arrow_renew"
                let sectionView = TYSSectionView.initWithLeftTitle(title: title!, image: image!)
                reusableview.addSubview(sectionView)
            } else if indexPath.section == 2 {
                title = "热门"
                image = "default_arrow_right"
                let sectionView = TYSSectionView.initWithLeftTitle(title: title!, image: image!)
                reusableview.addSubview(sectionView)
            } else {
                title = "推荐"
                image = "default_arrow_right"
                let sectionView = TYSSectionView.initWithLeftTitle(title: title!, image: image!)
                reusableview.addSubview(sectionView)
            }
            
        }

        return reusableview
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let height = lround(Double(kBannerHeight + kNavigationBarHeight))
        if offsetY < 0 {
            if offsetY > -CGFloat(height) {
                let alpha = -kBannerHeight / offsetY
                navBarBackgroundAlpha = alpha
                navigationItem.titleView = searchBtn
                searchBtn?.alpha = alpha
            } else {
                navBarBackgroundAlpha = 0
                navigationItem.titleView = nil
                searchBtn?.alpha = 0
            }
        } else {
            navBarBackgroundAlpha = 1.0
            navigationItem.titleView = searchBtn
            searchBtn?.alpha = 1.0
        }
    }
    
    
    /// 点击图片事件
    func cycleScrollViewDidSelect(at index:Int, cycleScrollView:WRCycleScrollView) {
        print("点击了第\(index+1)个图片")
    }
    /// 图片滚动事件
    func cycleScrollViewDidScroll(to index:Int, cycleScrollView:WRCycleScrollView) {
//        print("滚动到了第\(index+1)个图片")
    }

}




