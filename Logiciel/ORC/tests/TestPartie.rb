# -*- coding: utf-8 -*-
require('../kernel/Partie.rb')
require('../kernel/Commentaire.rb')
require('../kernel/Utilisateur.rb')
##############################################################################
# Projet L3 Groupe 2 : Test Unitaire de la classe Partie
#
# Teste les méthodes et fonctionnalités de la classe partie
#
# dernière modification :	25/03/07, N. Dupont
##############################################################################

part1 = Partie.creer(1,"titre1","Il était une fois ans, il y a fort longtemps ...")
util = Utilisateur.creerContributeur("Cachou","frieskies","cachou@gmail.com")
com1 = Commentaire.creer(1,"Ce commentaire est un test",util)
com2 = Commentaire.creer(2,"Autre blabla",util)
part1.ajouterCommentaire(com1)
part1.ajouterCommentaire(com2)
puts part1
puts "ajouter commentaires"
part1.eachCommentaire do |com|
	puts com
end
puts "retirer commentaire 1"
part1.retirerCommentaire(com1)
part1.eachCommentaire do |com|
	puts com
end
puts "incrémenter compteur"
part1.incrementerCompteur()
puts part1
puts "décrémenter compteur"
part1.decrementerCompteur()
puts part1
puts "modifier contenu"
part1.modifierContenu("Il était une fois, en fait c'était hier ...")
puts part1
