# -*- coding: utf-8 -*-
require('../kernel/Document.rb')
require('../kernel/Utilisateur.rb')
require('../kernel/Paragraphe.rb')
require('../kernel/Commentaire.rb')
require('../kernel/Image.rb')
##############################################################################
# Projet L3 Groupe 2 : Test Unitaire de la classe Document
#
# Teste les méthodes et fonctionnalités de la classe Document
#
# dernière modification :	25/03/07, N. Dupont
# todo :
##############################################################################

auteur = Utilisateur.creerContributeur("Cachou","frieskies","cachou@gmail.com")
auteur.devenirAuteur()
util1 = Utilisateur.creerContributeur("Gribouille","wiskas","grigri@gmail.com")
util2 = Utilisateur.creerContributeur("Garfield","ronron","garfield@gmail.com")
contributeurs = [util1,util2]

auteur.enregistrer()
util1.enregistrer()
util2.enregistrer()

part1 = Paragraphe.creer(1,"pouic","Il était une fois ans, il y a fort longtemps ...\nfdsfdsfds\nfdsfds\nfdsfds")
com1 = Commentaire.creer(1,"Ce commentaire est un test\nfdsfdsfds\nfdsfds\nfdsfds",contributeurs[0])
com2 = Commentaire.creer(2,"Autre blabla",contributeurs[1])
part1.ajouterCommentaire(com1)
part1.ajouterCommentaire(com2)
part2 = Paragraphe.creer(3,"pouic","Il se marièrent et eurent beaucoup d'enfants ...")
part3 = Image.creer(2,"im1","../imageTest.jpg")
part4 = Paragraphe.creer(4,"pouic","Partie 4\nfdsfdsfds\nfdsfds\nfdsfds")
part5 = Paragraphe.creer(5,"pouic","Partie 5\nfdsfdsfds\nfdsfds\nfdsfds")
part6 = Paragraphe.creer(6,"pouic","Partie 6\nfdsfdsfds\nfdsfds\nfdsfds")
part8 = Paragraphe.creer(8,"pouic","Partie 8\nfdsfdsfds\nfdsfds\nfdsfds")
part9 = Paragraphe.creer(9,"pouic","Partie 9\nfdsfdsfds\nfdsfds\nfdsfds")
part10 = Paragraphe.creer(10,"pouic","Partie 10\nfdsfdsfds\nfdsfds\nfdsfds")
part11= Paragraphe.creer(11,"pouic","Partie 11\nfdsfdsfds\nfdsfds\nfdsfds")
part12= Paragraphe.creer(12,"pouic","Partie 12\nfdsfdsfds\nfdsfds\nfdsfds")
part13= Paragraphe.creer(13,"pouic","Partie 13\nfdsfdsfds\nfdsfds\nfdsfds")
part14= Paragraphe.creer(14,"pouic","Partie 14\nfdsfdsfds\nfdsfds\nfdsfds")
part15= Paragraphe.creer(15,"pouic","Partie 15\nfdsfdsfds\nfdsfds\nfdsfds")

doc = Document.creer(1, "Les recettes de grand-mère",true,"recueil de recettes de cuisine",auteur,contributeurs)

puts "\ninsérer parties 1, 2, 3"

doc.insererPartieApres(part1,nil)
doc.insererPartieApres(part2,part1)
doc.insererPartieApres(part3,part1)
doc.insererPartieApres(part4,part1)
doc.insererPartieApres(part5,part1)
doc.insererPartieApres(part6,part1)
doc.insererPartieApres(part8,part1)
doc.insererPartieApres(part9,part1)
doc.insererPartieApres(part10,part1)
doc.insererPartieApres(part11,part1)
doc.insererPartieApres(part12,part1)
doc.insererPartieApres(part13,part1)
doc.insererPartieApres(part14,part1)
doc.insererPartieApres(part15,part1)

p doc

puts "enregistrer :"
doc.enregistrer()

p doc

puts "\nsupprimer partie 2"
doc.retirerPartie(part2)

p doc

puts "\nsupprimer partie 1"
doc.retirerPartie(part1)

p doc

puts "enregistrer :"
doc.enregistrer()

p doc

puts "\najouter contributeurs"
util1 = Utilisateur.creerContributeur("Océane","oce","oceane@gmail.com")
util2 = Utilisateur.creerContributeur("Félix","fel","felix@gmail.com")
doc.ajouterContributeur(util2)
doc.ajouterContributeur(util1)

p doc

puts "\nretirer contributeur felix"
doc.retirerContributeur(util2)

p doc

puts "\nretirer contributeur oceane"
doc.retirerContributeur(util1)

p doc

puts "enregistrer :"
doc.enregistrer()

p doc

puts "apres chargement"
doc2 = Document.charger(doc.numero())

p doc2

puts "enregistrer version :"
doc2.enregistrerVersion()

p doc2

puts "charger version :"
doc3 = Document.charger(doc2.numero(),doc2.numeroVersion())

p doc3

p doc3.donnerHistorique()
