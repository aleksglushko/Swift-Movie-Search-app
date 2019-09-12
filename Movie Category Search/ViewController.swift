//
//  ViewController.swift
//  Movie Category Search
//
//  Created by Aleksandr Glushko on 06.09.19.
//  Copyright © 2019 tardis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var loginViewController: LoginViewController!
    private var homeViewController: HomeViewController!
    private var movieViewController: MovieViewController!
    
    @IBAction func switchViews(sender: UIBarButtonItem){
        // Создаем новый контроллер представления при необходимости
        if movieViewController?.view.superview == nil {
            if movieViewController == nil {
                movieViewController = storyboard?.instantiateViewController(withIdentifier: "Home") as! MovieViewController
            }
        } else if homeViewController?.view.superview == nil {
            if homeViewController == nil {
                homeViewController = storyboard?.instantiateViewController(withIdentifier: "Home") as! HomeViewController
                    }
        }
                
        // Переключаем контроллеры представления
        if homeViewController != nil && homeViewController!.view.superview != nil { movieViewController.view.frame = view.frame
            switchViewController(from: homeViewController, to: movieViewController)
        } else {
            homeViewController.view.frame = view.frame
            switchViewController(from: movieViewController, to: homeViewController)
        }
                
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Дополнительная настройка после загрузки представления .
        homeViewController = storyboard?.instantiateViewController(withIdentifier: "Home") as! HomeViewController
        homeViewController.view.frame = view.frame
        switchViewController(from: nil, to: homeViewController) // вспомогательный метод
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // free the memory
        
        if homeViewController != nil && homeViewController!.view.superview == nil {
            homeViewController = nil
        }
        
        if loginViewController != nil && loginViewController!.view.superview == nil {
            loginViewController = nil
        }
        
        if movieViewController != nil && movieViewController!.view.superview == nil {
            movieViewController = nil
        }
    }
    
    private func switchViewController(from fromVC: UIViewController?, to toVC: UIViewController?){
        if fromVC != nil {
            fromVC!.willMove(toParent: nil)
            fromVC!.view.removeFromSuperview()
            fromVC!.removeFromParent()
        }
        
        if toVC != nil {
            self.addChild(toVC!)
            self.view.insertSubview(toVC!.view, at: 0)
            toVC!.didMove(toParent: self)
        }
    }
    


}

