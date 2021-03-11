//
//  LaunchScreenVC.swift
//  RotationLucky
//
//  Created by Macbook on 2/25/21.
//

import UIKit

class LaunchScreenVC: UIViewController {
    
    private let imageView:UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(named: "icons8-color-wheel-96")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.animate()
        })
    }
    
    private func animate() {
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 1.5
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            self.imageView.frame = CGRect(x: -(diffX/2),
                                          y: diffY/2,
                                          width: size,
                                          height: size)
        })
        UIView.animate(withDuration: 1.5, animations: {
            self.imageView.alpha = 0
        }, completion: { (done) in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let homevc = storyboard.instantiateViewController(withIdentifier: HomePageVC.className) as! HomePageVC
                    homevc.modalTransitionStyle = .crossDissolve
                    homevc.modalPresentationStyle = .fullScreen
                    self.present(homevc, animated: true, completion: nil)
                })
            }
        })

    }
    

}
