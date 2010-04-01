# -*- coding: utf-8 -*-

require "../kernel/MessagerieAdmin.rb"
require "../kernel/Messagerie.rb"
require "../kernel/Message.rb"
require "../kernel/DemandeInscription.rb"
require "../Parametres.rb"

##############################################################################
# Projet L3 Groupe 2 : Test Unitaire de la classe MessagerieAdmin
#
# Teste l'ajout et la suppression de demandes d'inscription
#
# dernière modification :	30/03/07, Romain
##############################################################################

d1 = DemandeInscription.new(1,"toto","mdpToto","toto@toto.fr","je veux etre contrib",STATUT_CONTRIBUTEUR)
d2 = DemandeInscription.new(2,"titi","mdpTiti","toto@toto.fr","je veux etre admin",STATUT_ADMINISTRATEUR)
d3 = DemandeInscription.new(3,"tutu","mdpTutu","toto@toto.fr","je veux etre auteur",STATUT_AUTEUR)

m = MessagerieAdmin.new()

puts "chargement de la messagerie admin"
m.chargerMessagerie()

puts
puts "affichage contenu"
m.afficherMessagerie()

puts
puts "reception demandes"
m.recevoirMessage(d1)
m.recevoirMessage(d2)
m.recevoirMessage(d3)

puts
puts "affichage contenu"
m.afficherMessagerie()

puts
puts "Suppression 2eme demande"
m.supprimerMessage(d2.id)

puts "Reception d'une demande"

d4 = DemandeInscription.new(4,"tete","mdpTete","toto@toto.fr","je veux etre contrib",STATUT_CONTRIBUTEUR)
m.recevoirMessage(d4)

puts
puts "On vérifie que ca a bien sauvegardé"

m.chargerMessagerie()
m.afficherMessagerie()



