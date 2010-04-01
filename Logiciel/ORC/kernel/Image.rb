# -*- coding: utf-8 -*-

##############################################################################
# Projet L3 Groupe 2 : classe Image
#
# ...
#
# dernière modification :	01/04/07, Julien
##############################################################################
class Image < Partie
	
	# construire une nouvelle partie image
	# param contenu : String
	# param numero : Fixnum
	def Image.creer(numero, titre, contenu)
		new(numero, titre, contenu)
	end
	
	# retourner le widget qui contient l'image
	# retour : EventBoxModifImage
	def afficher()
		retour = EventBoxModifImage.new()
		retour.changerImage(@contenu)
		retour.contenu = self
		retour.modify_bg(Gtk::STATE_NORMAL, COULEUR_DESELECTIONNE)
		return retour
	end
	
	# modifier le widget contenant l'image
	def modifier(fenetre)
		FenetreEditerImage.new(self)
		fenetre.modifierImage()
	end
  
end
