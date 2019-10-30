//
//  ConcentrarionThemeChooserViewController.swift
//  concentration
//
//  Created by Roman Zakharov on 30/10/2019.
//  Copyright © 2019 Роман Захаров. All rights reserved.
//

import UIKit

struct Theme: Equatable {
    var backgroundColor: UIColor
    var cardBackColor: UIColor
    var emojiString: String
}

let themes = ["Halloween": Theme(backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardBackColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), emojiString: "🎃👻😈🍭🦇🧛🏻‍♀️🦉🕷🕸🍬⚰️🔮🎈✝️"),
              "Animals": Theme(backgroundColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), cardBackColor: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), emojiString: "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷🐸🐵"),
              "Fruits": Theme(backgroundColor: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), cardBackColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), emojiString: "🍎🍐🍊🍋🍌🍉🍇🍓🍒🍑🥭🍍🥥🥝🍆"),
              "Sports": Theme(backgroundColor: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), cardBackColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), emojiString: "⚽️🏀🏈⚾️🎾🏐🏉🥏🎱🎲🎳🥌🥊🏆")]

class ConcentrarionThemeChooserViewController: UIViewController,
                                               UITableViewDataSource,
                                               UITableViewDelegate,
                                               UISplitViewControllerDelegate {

    override func awakeFromNib() {
        splitViewController?.delegate = self
    }

    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }

    @IBOutlet weak var tableView: UITableView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return themes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Theme Chooser Button")!
        cell.textLabel?.text = themes.keys.sorted()[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if let cvc = splitViewDetailCVC {
            if let themeName = cell?.textLabel?.text,
                let theme = themes[themeName] {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedToCVC {
            if let themeName = cell?.textLabel?.text,
                let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: cell)
        }
    }

    private var splitViewDetailCVC: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }

    private var lastSeguedToCVC: ConcentrationViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UITableViewCell)?.textLabel?.text, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToCVC = cvc
                }
            }
        }
    }
}
