//
//  TYSHomeViewController.swift
//  SwiftTools
//
//  Created by 张书孟 on 2018/3/20.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import MJRefresh

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
    private var dataSource = [TYSHomeLiveModel]()
    private var interestedPeoDataSource = [TYSInterestedPeopleModel]()
    private var featureDataSource = [
        ["featureImg": "home_icon_roadshow", "featureTitle": "路演"],
        ["featureImg": "home_icon_metting", "featureTitle": "电话会议"],
        ["featureImg": "home_icon_reading", "featureTitle": "荐读"],
        ["featureImg": "home_icon_connection", "featureTitle": "人脉"]]
    
    private var cycleLinkPathDataSource = [String]()
    private var cycleImgPathDataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        
        setupUI()
    }
    
    private func requestHomeData() {
        let param = ["requestCode" : "89000", "user_id" : loginModel.user_id ?? ""]
        requestHomeListData(paramterDic: param, cacheCompletion: { (cacheValue) in
            
            self.dataSource.removeAll()
            self.dataSource.append(cacheValue)
            self.collectionView.reloadData()
            
        }, successCompletion: { (value) in
            if self.collectionView.mj_header.isRefreshing {
                self.collectionView.mj_header.endRefreshing()
            }
            self.dataSource.removeAll()
            self.dataSource.append(value)
            self.collectionView.reloadData()
        }) { (failure) in
            showFail(text: "网络异常")
            if self.collectionView.mj_header.isRefreshing {
                self.collectionView.mj_header.endRefreshing()
            }
        }
    }
    
    private func requestInterestedPeopleData() {
        let param = ["requestCode" : "V219001", "page" : "1", "limit" : "10", "login_user_id" : loginModel.user_id ?? ""]
        
        requestInterestedPeople(paramterDic: param, cacheCompletion: { (cacheValue) in
            self.interestedPeoDataSource.removeAll()
            self.interestedPeoDataSource = cacheValue
            self.collectionView.reloadData()
        }, successCompletion: { (valueArray) in
            if self.collectionView.mj_header.isRefreshing {
               self.collectionView.mj_header.endRefreshing()
            }
            
            self.interestedPeoDataSource.removeAll()
            self.interestedPeoDataSource = valueArray
            self.collectionView.reloadData()
        }) { (failure) in
            showFail(text: "网络异常")
            if self.collectionView.mj_header.isRefreshing {
                self.collectionView.mj_header.endRefreshing()
            }
        }
    }
    
    private func requestHomeADData() {
        let param = ["requestCode" : "95000", "page" : "1", "limit" : "10", "position" : "HOME"]
        requestHomeAD(paramterDic: param, cacheCompletion: { (cacheValue) in
            self.cycleLinkPathDataSource.removeAll()
            self.cycleImgPathDataSource.removeAll()
            for index in 0..<cacheValue.count {
                self.cycleImgPathDataSource.append(cacheValue[index].img_path!)
                self.cycleLinkPathDataSource.append(cacheValue[index].link_path!)
            }
            self.cycleScrollView?.serverImgArray = self.cycleImgPathDataSource
        }, successCompletion: { (valueArray) in
            if self.collectionView.mj_header.isRefreshing {
                self.collectionView.mj_header.endRefreshing()
            }
            self.cycleLinkPathDataSource.removeAll()
            self.cycleImgPathDataSource.removeAll()
            for index in 0..<valueArray.count {
                self.cycleImgPathDataSource.append(valueArray[index].img_path!)
                self.cycleLinkPathDataSource.append(valueArray[index].link_path!)
            }
            self.cycleScrollView?.serverImgArray = self.cycleImgPathDataSource
        }) { (failure) in
            showFail(text: "网络异常")
            if self.collectionView.mj_header.isRefreshing {
                self.collectionView.mj_header.endRefreshing()
            }
        }
    }
}

// MARK: setupUI
extension TYSHomeViewController {
    
    private func setupUI() {
        setupNav()
        createCollectionView()
        createCycleScrollView()
        self.collectionView.mj_header.beginRefreshing()
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
            make.top.equalTo(view.snp.top).offset(-kNavigationBarHeight)
        }
        
        collectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.requestHomeADData()
            self?.requestHomeData()
            self?.requestInterestedPeopleData()
        })

        collectionView.mj_header.ignoredScrollViewContentInsetTop = kBannerHeight
    }
    
    private func createCycleScrollView() {
        let height = kBannerHeight
        let frame = CGRect(x: 0, y: -height, width: kScreenW, height: height)
        let imgs = ["defualt_banner"]
        
        cycleScrollView = WRCycleScrollView(frame: frame, type: .SERVER, imgs: imgs, defaultDotImage: UIImage(named: "defaultDot"), currentDotImage: UIImage(named: "currentDot"), placeholderImage: UIImage(named: "defualt_banner"))
        cycleScrollView?.delegate = self
        collectionView.addSubview(cycleScrollView!)
        
    }
}

// MARK: event response
extension TYSHomeViewController {
    @objc private func personalCenter() {
        let personalVc = TYSPersonalViewController()

        navigationController?.pushViewController(personalVc, animated: true)
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
            
            return CGSize(width: AdaptW(w: 158), height: AdaptH(h: 215))
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
        
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            if dataSource.first?.home_tj_live == nil {
                return 0
            } else {
                return 1
            }
        default:
            if dataSource.first?.home_tj_live == nil {
                return 0
            } else {
                return (dataSource.first?.home_tj_live?.count)!
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: TYSHomeTabCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TYSHomeTabCollectionViewCell", for: indexPath) as! TYSHomeTabCollectionViewCell
            cell.setTabArray(tabArray: featureDataSource)
            
            cell.didSelectedItemAction(tempClick: {[weak self] (index) in
                switch index {
                case 0:
                    self?.navigationController?.pushViewController(TYSRoadShowViewController(), animated: true)
                    break
                case 1:
                    self?.navigationController?.pushViewController(TYSTelViewController(), animated: true)
                    break
                case 2:
                    self?.navigationController?.pushViewController(TYSRecReadViewController(), animated: true)
                    break
                    
                default:
                    self?.navigationController?.pushViewController(TYSConnectionViewController(), animated: true)
                    break
                }
            })
            return cell
            
        case 1:
            
            let cell: TYSLikelyPeopleCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TYSLikelyPeopleCollectionViewCell", for: indexPath) as! TYSLikelyPeopleCollectionViewCell
            cell.setInterestedPeoArray(interestedPeoArray: interestedPeoDataSource)
            return cell
            
        case 2:
            
            let cell: TYSHotCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TYSHotCollectionViewCell", for: indexPath) as! TYSHotCollectionViewCell
            let modelArr = dataSource.first?.home_hot_live
            cell.hotArr = modelArr!
            
            cell.didSelectedItemAction(tempDidselectedItem: {[weak self] (index) in
                self?.liveDetail(liveListModel: modelArr![index])
            })
            
            return cell
            
        default:
            let cell: TYSCommonCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TYSCommonCollectionViewCell", for: indexPath) as! TYSCommonCollectionViewCell
            let model = dataSource.first?.home_tj_live![indexPath.item]
            cell.setModel(model: model!)
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
                let sectionView = TYSSectionView().initWithLeftTitle(title: title!, image: image!)
                sectionView.addRightBtnAction(tempRightBtnAction: {[weak self] (button) in
                    self?.requestInterestedPeopleData()
                })
                reusableview.addSubview(sectionView)
            } else if indexPath.section == 2 {
                title = "热门"
                image = "default_arrow_right"
                let sectionView = TYSSectionView().initWithLeftTitle(title: title!, image: image!)
                sectionView.addRightBtnAction(tempRightBtnAction: {[weak self] (button) in
                    self?.navigationController?.pushViewController(TYSHotLiveViewController(), animated: true)
                })
                reusableview.addSubview(sectionView)
            } else {
                title = "推荐"
                image = "default_arrow_right"
                let sectionView = TYSSectionView().initWithLeftTitle(title: title!, image: image!)
                sectionView.addRightBtnAction(tempRightBtnAction: {[weak self] (button) in
                    self?.navigationController?.pushViewController(TYSRecLiveViewController(), animated: true)
                })
                reusableview.addSubview(sectionView)
            }
            
        }

        return reusableview
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            liveDetail(liveListModel: (dataSource.first?.home_tj_live![indexPath.item])!)
        }
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
        
        let VC = TYSHomeWebViewController()
        VC.url = cycleLinkPathDataSource[index]
        
        navigationController?.pushViewController(VC, animated: true)
    }
    /// 图片滚动事件
    func cycleScrollViewDidScroll(to index:Int, cycleScrollView:WRCycleScrollView) {
//        print("滚动到了第\(index+1)个图片")
    }

}




