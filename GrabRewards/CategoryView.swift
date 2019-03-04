//
//  CategoryView.swift
//  GrabRewards
//
//  Created by Ky Nguyen on 3/4/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit

let padding: CGFloat = 24
private let viewHeight: CGFloat = 150
struct Category {
    var icon: String?
    var name: String?
    init(icon: String, name: String) {
        self.icon = icon
        self.name = name
    }
}

class CategoryView: knView {
    var datasource = [Category]() { didSet { collectionView.reloadData() }}
    var collectionView: UICollectionView!
    
    override func setupView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCollectionCell.self,
                                forCellWithReuseIdentifier: "CategoryCollectionCell")
        collectionView.contentInset = UIEdgeInsets(left: padding / 2, right: padding / 2)
        addSubviews(views: collectionView)
        collectionView.fill(toView: self)
        collectionView.height(viewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return datasource.count }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath) as! CategoryCollectionCell
        cell.data = datasource[indexPath.row]
        cell.backgroundColor = .green
        return cell
    }
    
}

extension CategoryView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 96, height: viewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


class CategoryCollectionCell: UICollectionViewCell {
    let iconImageView = UIMaker.makeImageView()
    let nameLabel = UIMaker.makeLabel(alignment: .center)
    
    var data: Category? {
        didSet {
            if let icon = data?.icon {
                iconImageView.image = UIImage(named: icon)
            }
            
            nameLabel.text = data?.name
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        let iconWrapper = UIMaker.makeView()
        iconWrapper.addSubviews(views: iconImageView)
        iconImageView.square(edge: 32)
        iconImageView.center(toView: iconWrapper)
        addSubviews(views: iconWrapper, nameLabel)
        
        iconWrapper.setCorner(radius: 36)
        iconWrapper.square()
        iconWrapper.horizontal(toView: self, space: padding / 2)
        iconWrapper.backgroundColor = .lightGray
        iconWrapper.top(toView: self, space: padding)
        
        nameLabel.horizontal(toView: self, space: padding / 2)
        nameLabel.verticalSpacing(toView: iconWrapper, space: padding / 2)
    }
}
