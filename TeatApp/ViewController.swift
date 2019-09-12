//
//  ViewController.swift
//  TeatApp
//
//  Created by 王冠之 on 2019/9/2.
//  Copyright © 2019 wangkuanchih. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    var searchBar: UISearchBar!
    var roomCollectionView: UICollectionView!
    var additionDatasource: [Addition] = []
    var roomDataSource: [Room] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        commomInit()
        
    }

    func commomInit() {
        //初始化
        searchBar = UISearchBar()
        //不要讓frame自己決定排版
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        //自己決定style
        searchBar.searchBarStyle = .minimal
        //預設文字
        searchBar.placeholder = "尋找房源..."
        //不要是半透明的格式
        searchBar.isTranslucent = true
        searchBar.delegate = self
        view.addSubview(searchBar)
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        //設定cell
        let roomLayout = UICollectionViewFlowLayout()
        roomLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width-32-34)/2, height: 180)
        
        //cell左右的距離
        roomLayout.minimumLineSpacing = 24
        roomLayout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 420 )
        
        roomCollectionView = UICollectionView(frame: .zero, collectionViewLayout: roomLayout )
        roomCollectionView.translatesAutoresizingMaskIntoConstraints = false
        roomCollectionView.backgroundColor = UIColor.white
        roomCollectionView.delegate = self
        roomCollectionView.dataSource = self
        //顯示滑軸
        roomCollectionView.showsVerticalScrollIndicator = false
        //上下左右往內縮的距離
        roomCollectionView.contentInset = UIEdgeInsets(top:  0, left: 16, bottom: 0, right: 16)
        
        roomCollectionView.register(UINib(nibName: "RoomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell_room")
        roomCollectionView.register(CollectionHeaderView.self , forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        view.addSubview(roomCollectionView)
        roomCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
        roomCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        roomCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        roomCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        ServiceHandler.sharedHandeler.fetchRoomData { ( ContentDataModel) in
            if let contentDataModel = ContentDataModel {
                DispatchQueue.main.async {
                    self.additionDatasource = contentDataModel.plusData
                    self.roomDataSource = contentDataModel.roomList
                    self.roomCollectionView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UISearchBarDelegate{
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roomDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier:  "cell_room", for: indexPath) as! RoomCollectionViewCell
        let room = roomDataSource[indexPath.row]
        cell.titleLabel.text = room.name
        cell.priceLabel.text = "$\(room.price)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let resableHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! CollectionHeaderView
            resableHeaderView.additionDatasource = additionDatasource
            return resableHeaderView
        } else {
            return UICollectionReusableView()
        }
    }
}
