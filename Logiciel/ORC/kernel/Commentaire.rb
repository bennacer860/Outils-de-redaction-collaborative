# -*- coding: utf-8 -*-
##############################################################################
# Projet L3 Groupe 2 : classe Commentaire
#
# Les commentaires déposés sur des parties
#
# dernière modification :	03/04/07, Max (attr:numero & tabReferents, tabReferents, ajouterReferent, hasRef)
##############################################################################


class Commentaire
	
	@numero			# Fixnum : identificateur du commentaire
	@texte	 		# String : le texte
	@auteur			# Utilisateur : l'auteur
	@tabReferents	# Array : id des commentaires faisant référence au commentaire courant
        @partie # partie que le commentaire commente
	@reference #Fixnum : identificateur du commentaire de reference
	attr_reader:texte
	attr_reader:auteur
	attr_reader:numero
	attr_reader:partie
	attr_reader:tabReferents
	
	# construire un nouveau commentaire
	# param num : Fixnum
	# param text : String
	# param aut : Utilisateur
	def Commentaire.creer(num, text, aut, partie)
		Commentaire.new(num, text, aut, partie)
	end

	# initialiser le nouveau commentaire
	# param num : Fixnum
	# param text : String
	# param aut : Utilisateur
	def initialize(num, text, aut, partie)
		@numero, @texte, @auteur, @reference, @partie = num, text, aut, nil, partie
		@tabReferents = Array.new()
	end
	
	# donner la description du commentaire
	# retour : String
	def to_s()
		return @auteur.nom()+" a écrit le commentaire "+@numero.to_s()+" : "+@texte
	end
	
	# retourner le widget contenant le commentaire
	# retour : EventBoxModifParagraphe
	def afficher()
		retour = EventBoxModifParagraphe.new()
		
		if(@reference==0)
			retour.changerTexte("- #{@partie.titre}, commentaire #{@numero}\n#{@auteur.nom} dit : #{@texte}")
		else
			retour.changerTexte("- #{@partie.titre}, commentaire #{@numero} (en référence au commentaire #{@reference})\n#{@auteur.nom} dit : #{@texte}")
		end
		retour.contenu = self
		retour.modify_bg(Gtk::STATE_NORMAL, COULEUR_DESELECTIONNE)
		return retour
	end

	# ajouter un référent
	# param numero : Fixnum 
	def ajouterReferent(numero)
		@tabReferents.push(numero)
		return self
	end

	# retirer un référent
	# param numero : Fixnum
	def retirerReferent(numero)
		@tabReferents.delete(numero)
		return self
	end

	#retourne vrai si le commentaire est référencé par d'autre commentaires
	# retour : boolean
	def hasRef?()
		return !@tabReferents.empty?()
	end
	
	#indique le commentaire de reference
	#param : id du commentraire de reference
	def ajouterRef(id)
		@reference = id
	end

end
