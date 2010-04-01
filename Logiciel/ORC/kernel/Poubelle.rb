# -*- coding: utf-8 -*-
##############################################################################
# Projet L3 Groupe 2 : classe Poubelle
#
# La poubelle permet de stocker temporairement des parties à supprimer, elles seront traitées à la sauvegarde du document
#
# dernière modification :	25/03/07, N. Dupont
##############################################################################
class Poubelle
	
	@listeParties	# Array : les parties à supprimer
	
	# initialiser la poubelle
	def initialize()
		@listeParties = Array.new()
	end
	
	# vérifier si la poubelle est vide
	# retour : Boolean
	def estVide?()
		@listeParties.empty?()
	end
	
	# ajouter la partie
	# param partie : Partie
	def ajouterPartie(partie)
		@listeParties.push(partie)
	end
	
	# retirer la partie
	# param partie : Partie
	def retirerPartie(partie)
		@listeParties.delete(partie)	
	end
	
	# afficher le contenu de la poubelle
	# retour : String
	def to_s()
		contenu = ""
		@listeParties.each do |partie| 
			contenu = contenu +"\n"+ partie.to_s()
		end
		return contenu
	end
	
	# vider la poubelle
	def vider()
		@listeParties.each do |partie| 
			if partie.compteur() == 0
				partie.supprimer()
			end
		end
		@listeParties.clear()
	end
	
	# permettre l'utilisation du eachPartie | bloc de code |
	def eachPartie()
		for item in @listeParties
			yield(item) # yield exécute le bloc appelant
		end
	end
	
end