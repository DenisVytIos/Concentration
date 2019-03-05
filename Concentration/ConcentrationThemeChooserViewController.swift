//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Denis on 19.02.2019.
//  Copyright © 2019 Denis Vitrishko. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    //Эту переменую будем устанавливать каждый раз когда переезжаем.Переменная является  последним ConcentrationViewController куда я переехал
    // Переменая будет удерживать в куче вью контроллер даже если ми нажмем кнопку "назад" т.к. это обычная сторонг переменная
   //31
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController?{
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    //36
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController{
            if cvc.theme == nil{
                return true
            }
        }
        return false
    }
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController{
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                cvc.theme = theme
                }
            }else if let cvc = lastSeguedToConcentrationViewController{
                if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                    cvc.theme = theme
                }
                navigationController?.pushViewController(cvc, animated: true)
            }else {
                performSegue(withIdentifier: "Choose Theme", sender: sender as! UIButton)
            }
        
    }
    
    
    let themes = [
         "Sports": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓⛷🎳⛳️",
        "Animals": "🐶🦆🐹🐸🐘🦍🐓🐩🐦🦋🐙🐏",
          "Faces": "😀😌😎🤓😠😤😭😰😱😳😜😇"
    ]
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //В приложении, основанном на раскадровке, вам часто нужно немного подготовиться перед навигацией
    
    // Get the new view controller using segue.destinationViewController.
    //Получите новый контроллер представления, используя segue.destinationViewController.
    // Pass the selected object to the new view controller.
    // Передать выбранный объект новому контроллеру представления
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme"{
                if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                    if let cvc = segue.destination as? ConcentrationViewController{
                        cvc.theme = theme
                        lastSeguedToConcentrationViewController = cvc
                    }
                }
        }
        
    }
    
}


