# -*- coding: utf-8 -*-
require('../kernel/Utilisateur.rb')
require('../kernel/GestionnaireUtilisateur.rb')
##############################################################################
# Projet L3 Groupe 2 : Test Unitaire de la classe Utilisateur
#
# Teste les différentes méthodes de l'utilisateur
#
# dernière modification :	25/03/07, N. Dupont
##############################################################################

gestU = GestionnaireUtilisateur.new()
gestU.chargerUtilisateurs()

# créer et sauvegarder 3 utilisateurs
puts "avant sauvegarde :"
gest = GestionnaireUtilisateur.new()
util1 = Utilisateur.creerContributeur("Cachou","frieskies","cachou@gmail.com")
util1.devenirAuteur()
gestU.ajouterUtilisateur(util1)
puts util1

util2 = Utilisateur.creerContributeur("Gribouille","wiskas","grigri@gmail.com")
util2.devenirAuteur()
gestU.ajouterUtilisateur(util2)
puts util2

util3 = Utilisateur.creerContributeur("admin","admin","garfield@gmail.com")
util3.devenirAdministrateur()
gestU.ajouterUtilisateur(util3)
puts util3

puts gestU.donnerUtilisateurs()

gestU.each do |util|
	puts util.nom()
end

# supprimer les utilisateurs
gestU.supprimerUtilisateur("Cachou")
gestU.supprimerUtilisateur("Gribouille")
gestU.supprimerUtilisateur("admin")



