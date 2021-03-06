//
//  MovieTableCell.swift
//  NetflixMVVM
//
//  Created by Ben Sullivan on 18/07/2017.
//  Copyright © 2017 Ben Sullivan. All rights reserved.
//

import UIKit

protocol MovieCellDelegate {
  func itemSelected(movie: Movie)
}

class MovieTableCell: UITableViewCell {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var delegate: MovieCellDelegate?
  
  var genre = Genre(name: "str", movies: [Movie(imageName: "movie-1")])
  
  func configureCell(withGenre genre: Genre) {
    self.genre = genre
    collectionView.reloadData()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
}

extension MovieTableCell: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return genre.movies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MovieCollectionCell

    cell.mainImage.image = UIImage(named: genre.movies[indexPath.row].imageName)
    
    return cell
  }
  
}

extension MovieTableCell: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    delegate?.itemSelected(movie: genre.movies[indexPath.row])
  }
}
