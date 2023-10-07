//
//  TagsVC.swift
//  social Media App
//
//  Created by mohamed ahmed on 29/08/2023.
//

import UIKit

class TagsVC: UIViewController {

    var x=["french","live","everyone","intelligences"]
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tagsCollectionView.dataSource=self
        tagsCollectionView.delegate=self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TagsVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        x.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        cell.nameTagLabel.text=x[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let st=storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
        st.tag=x[indexPath.row]
        present(st, animated: true)
    }
    
}
