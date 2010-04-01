# -*- coding: utf-8 -*-
require('../kernel/Poubelle.rb')
require('../kernel/Paragraphe.rb')
##############################################################################
# Projet L3 Groupe 2 : Test Unitaire de la classe Poubelle
#
# Teste les différentes méthodes de la poubelle
#
# dernière modification :	25/03/06, N. Dupont
##############################################################################
poubelle = Poubelle.new()
puts "poubelle :"+poubelle.to_s()
puts "poubelle est vide ? "+poubelle.estVide?().to_s()

poubelle.ajouterPartie(p1 = Paragraphe.new(1,"intro","mon chat s'appelle Cachou et il est tout noir."))
poubelle.ajouterPartie(p2 = Paragraphe.new(2,"part1","il passe son temps a jouer au baby-foot."))
poubelle.ajouterPartie(p3 = Paragraphe.new(3,"concl","c'est plutôt cool d'être un chat."))
puts "poubelle :"+poubelle.to_s()
puts "poubelle est vide ? "+poubelle.estVide?().to_s()

poubelle.eachPartie do |part| 
	puts "\t- "+part.contenu()
end
puts "poubelle :"+poubelle.to_s()
puts "poubelle est vide ? "+poubelle.estVide?().to_s()

poubelle.retirerPartie(p2)
puts "poubelle :"+poubelle.to_s()
puts "poubelle est vide ? "+poubelle.estVide?().to_s()

poubelle.vider()
puts "=>poubelle :"+poubelle.to_s()
puts "poubelle est vide ? "+poubelle.estVide?().to_s()