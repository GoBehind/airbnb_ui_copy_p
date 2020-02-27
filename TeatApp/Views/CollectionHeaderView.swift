 //
//  CollectionHeaderView.swift
//  TeatApp
//
//  Created by 王冠之 on 2020/2/20.
//  Copyright © 2020 wangkuanchih. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    var additionCollectionView: UICollectionView!
    var roomTitleLabel: UILabel!
    var additionDatasource: [Addition] = [] {
        didSet {
            self.additionCollectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //設定cell
        let additionLayout = UICollectionViewFlowLayout()
        additionLayout.scrollDirection = .horizontal
        additionLayout.itemSize = CGSize(width: 280, height: 310)
        
        //cell左右的距離
        additionLayout.minimumLineSpacing = 24
        
        additionCollectionView = UICollectionView(frame: .zero, collectionViewLayout: additionLayout)
        additionCollectionView.translatesAutoresizingMaskIntoConstraints = false
        additionCollectionView.backgroundColor = UIColor.white
        additionCollectionView.delegate = self
        additionCollectionView.dataSource = self
        //顯示滑軸
        additionCollectionView.showsHorizontalScrollIndicator = false
        
        additionCollectionView.register(UINib(nibName: "AdditionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        addSubview(additionCollectionView)
        
        additionCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        additionCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        additionCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        additionCollectionView.heightAnchor.constraint(equalToConstant: 330).isActive = true
        
        roomTitleLabel = UILabel(frame: CGRect.zero)
        roomTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        roomTitleLabel.text = "世界各地的房源"
        roomTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        roomTitleLabel.textColor = UIColor.black
        addSubview(roomTitleLabel)
        
        roomTitleLabel.topAnchor.constraint(equalTo: additionCollectionView.bottomAnchor, constant: 24).isActive = true
        roomTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        roomTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

 extension CollectionHeaderView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return additionDatasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AdditionCollectionViewCell
        
        let addition = additionDatasource[indexPath.row]
        cell.titleLabel.text = addition.title
        cell.descriptionLabel.text = addition.description
        return cell
    }
    
    
 }
