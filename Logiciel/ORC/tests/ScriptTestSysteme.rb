require('../Parametres.rb')
require('../kernel/Utilisateur.rb')
require('../kernel/Message.rb')
require('../kernel/Messagerie.rb')
require('../kernel/Document.rb')
require('../kernel/GestionnaireUtilisateur.rb')
msgToto=Message.new("Toto","Salut toi, je t'aime")
msgTiti=Message.new("Titi","Pas salut toi, je t'aime pas")
messagerie=Messagerie.new()
messagerie.recevoirMessage(msgToto)
messagerie.recevoirMessage(msgTiti)
Utilisateur.creerContributeur("admin","admin","admin@gmail.com",messagerie).devenirAdministrateur().enregistrer()
auteur = Utilisateur.creerContributeur("auteur","auteur","auteur@gmail.com",messagerie).devenirAuteur()
auteur.enregistrer()
contrib1 = Utilisateur.creerContributeur("contrib1","contrib1","contrib@gmail.com",messagerie)
contrib1.enregistrer()
contrib2 = Utilisateur.creerContributeur("contrib2","contrib2","contrib@gmail.com",messagerie)
contrib2.enregistrer()
contrib3 = Utilisateur.creerContributeur("contrib3","contrib3","contrib@gmail.com",messagerie)
contrib3.enregistrer()
contributeurs = [contrib1,contrib2,contrib3]
p contributeurs

gest = GestionnaireUtilisateur.new()
gest.chargerUtilisateurs()
p gest.donnerUtilisateurs()

test = Utilisateur.charger("admin")
puts test

part1 = Paragraphe.creer(1,"Il était une fois ans, il y a fort longtemps ...\nfdsfdsfds\nfdsfds\nfdsfds")
com1 = Commentaire.creer(1,"Ce commentaire est un test\nfdsfdsfds\nfdsfds\nfdsfds",contributeurs[0])
com2 = Commentaire.creer(2,"Autre blabla",contributeurs[1])
part1.ajouterCommentaire(com1)
part1.ajouterCommentaire(com2)
part2 = Paragraphe.creer(3,"Il se marièrent et eurent beaucoup d'enfants ...")
part3 = Image.creer(2,"../imageTest.jpg")
part4 = Paragraphe.creer(4,"Partie 4\nfdsfdsfds\nfdsfds\nfdsfds")
part5 = Paragraphe.creer(5,"Partie 5\nfdsfdsfds\nfdsfds\nfdsfds")
part6 = Paragraphe.creer(6,"Partie 6\nfdsfdsfds\nfdsfds\nfdsfds")
part8 = Paragraphe.creer(8,"Partie 8\nfdsfdsfds\nfdsfds\nfdsfds")
part9 = Paragraphe.creer(9,"Partie 9\nfdsfdsfds\nfdsfds\nfdsfds")
part10 = Paragraphe.creer(10,"Partie 10\nfdsfdsfds\nfdsfds\nfdsfds")
part11= Paragraphe.creer(11,"Partie 11\nfdsfdsfds\nfdsfds\nfdsfds")
part12= Paragraphe.creer(12,"Partie 12\nfdsfdsfds\nfdsfds\nfdsfds")
part13= Paragraphe.creer(13,"Partie 13\nfdsfdsfds\nfdsfds\nfdsfds")
part14= Paragraphe.creer(14,"Partie 14\nfdsfdsfds\nfdsfds\nfdsfds")
part15= Paragraphe.creer(15,"Partie 15\nfdsfdsfds\nfdsfds\nfdsfds")

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
