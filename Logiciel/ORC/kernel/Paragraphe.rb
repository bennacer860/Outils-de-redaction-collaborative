# -*- coding: utf-8 -*-

require 'gtk2'

##############################################################################
# Projet L3 Groupe 2 : classe Paragraphe
#
# ...
#
# dernière modification :	01/04/07, Julien
##############################################################################
class Paragraphe < Partie
	
	# construire une nouvelle partie paragraphe
	# param contenu : String
	# param numero : Fixnum
	# param titre : String
	def Paragraphe.creer(numero,titre, contenu)
		new(numero, titre, contenu)
	end
	
	# retourner le widget qui contient le paragraphe
	# retour : EventBoxModifParagraphe
	def afficher()
		retour = EventBoxModifParagraphe.new()
		retour.changerTexte(@contenu)
		retour.contenu = self
		retour.modify_bg(Gtk::STATE_NORMAL, COULEUR_DESELECTIONNE)
		return retour
	end
	
	# modifier le widget contenant le paragraphe
	def modifier(fenetre)
		FenetreEditerParagraphe.new(self)
		fenetre.modifierTexte()
	end
  
end
