# -*- coding: utf-8 -*-
require('../kernel/Commentaire.rb')
require('../kernel/Utilisateur.rb')
require('../kernel/GestionnaireUtilisateur.rb')
##############################################################################
# Projet L3 Groupe 2 : Test Unitaire de la classe Commentaire
#
# Teste les méthodes et fonctionnalités de la classe Commentaire
#
# dernière modification :	11/04/07, N. Dupont
##############################################################################
nom = "utilTest"
util = Utilisateur.creerContributeur(nom,"frieskies","cachou@gmail.com")
gestU = GestionnaireUtilisateur.new()
gestU.chargerUtilisateurs()
gestU.ajouterUtilisateur(util)
com1 = Commentaire.creer(1,"Ce commentaire1 est un test",util)
com2 = Commentaire.creer(1,"Ce commentaire2 est un test",util)
puts com1
puts com2
com1.ajouterReferent(com2.numero())
puts com1.hasRef?()
com1.retirerReferent(com2.numero())
puts com2.hasRef?()
gestU.supprimerUtilisateur(nom)

