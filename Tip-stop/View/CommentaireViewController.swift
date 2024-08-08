//
//  CommentaireViewModel.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 08/08/2024.
//
import UIKit

class CommentaireViewController: UIViewController {
    var commentaires: [Commentaire] = []

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func updateCommentaires(_ commentaires: [Commentaire]) {
        self.commentaires = commentaires
        tableView.reloadData()
    }
}

extension CommentaireViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentaires.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let commentaire = commentaires[indexPath.row]
        cell.textLabel?.text = "\(commentaire.utilisateur.nom): \(commentaire.contenu)"
        return cell
    }
}
