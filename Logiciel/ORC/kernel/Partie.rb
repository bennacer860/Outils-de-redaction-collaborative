# -*- coding: utf-8 -*-

require 'gtk2'
##############################################################################
# Projet L3 Groupe 2 : classe Partie
#
# La partie
#
# dernière modification :	25/03/07
##############################################################################
class Partie
	
	@numero			# Fixnum : numéro identifiant la partie
	@contenu		# String : le texte du paragraphe ou l'url de l'image
	@verrou			# Boolean : indique si la partie est modifiable par les contributeurs
	@compteur		# Fixnum :compteur du nombre de version utilisant cette partie
	@modifiee		# Boolean : indique si la partie a été modifiée depuis son chargement
	@commentaires	# Array : liste de commentaires
	@titre			# String : titre de la partie
	attr_reader:numero
	attr_accessor:contenu
	attr_reader:compteur
	attr_reader:verrou
	attr_accessor:titre
	 
	# construire une nouvelle partie
	# param contenu : String
	# param numero : Fixnum
	def Partie.creer(numero, titre, contenu)
		new(numero, titre, contenu)
	end

	# charger une nouvelle partie
	# param numero : Fixnum
	def Partie.charger(numero)
		path = PATH_PARTIES + "part_" + numero.to_s()+EXTENSION
		if(!File.exist?(path))
			puts("[CHARGEMENT PARTIE IMPOSSIBLE] : le fichier " + path + " n'existe pas !")
		else
			fichierSerialise = File.new(path,"r")
			partie = Marshal.load(fichierSerialise)
			fichierSerialise.close()
			return partie
		end
	end

	# initialiser la partie
	# param contenu : String
	# param numero : Fixnum
	def initialize(numero, titre, contenu)
		@numero, @contenu, @verrou, @compteur, @modifiee, @commentaires = numero, contenu, false, 1, true, Array.new()
		if titre != ""
			@titre = titre
		else
			@titre = self.class.to_s() + numero.to_s()
		end
	end

	# modifier le contenu
	# param texte : String
	def modifierContenu(texte)
		@contenu = texte
		@modifiee = true
	end

	# ajouter un commentaire
	# param commentaire : Commentaire
	def ajouterCommentaire(commentaire)
		@commentaires.push(commentaire)
		@modifiee = true
	end


	# retirer un commentaire
	# param commentaire : Commentaire
	def retirerCommentaire(commentaire)
		#si le commentaire a supprimer est référencé par d'autres commentaires, on les supprime
		if commentaire.hasRef?()
			self.eachCommentaire() do |com|
				if commentaire.tabReferents().include?(com.numero)
					commentaire.retirerReferent(com.numero)
					self.retirerCommentaire(com)
					self.retirerCommentaire(commentaire)
				end
			end
		else
		#si le commentaire est une référence a un autre commentaire, on le retire du tableau de Référents
		#de ce dernier
		self.eachCommentaire() do |com|
			if com.tabReferents().include?(commentaire.numero)
						com.retirerReferent(commentaire.numero)
			end
		end
		#on supprime enfin le commentaire
		@commentaires.delete(commentaire)
		@modifiee = true
		end
	end

	# permettre l'utilisation du eachCommentaire | bloc de code |
	def eachCommentaire()
		for item in @commentaires
			yield(item) # yield exécute le bloc appelant
		end
	end

	# incrémenter le compteur
	def incrementerCompteur()
		@compteur = @compteur + 1
	end
	
	# décrémenter le compteur
	def decrementerCompteur()
		@compteur = @compteur - 1
	end

	# enregistrer la partie
	def enregistrer()
		path = PATH_PARTIES + "part_" + @numero.to_s()+EXTENSION
		fichierSerialise = File.new(path,"w")
		Marshal.dump(self,fichierSerialise)
		fichierSerialise.close()
	end
	
	# supprimer la partie
	def supprimer()
		# construire le path et vérifier que le fichier existe bien
		path = PATH_PARTIES + "part_"+@numero.to_s()+EXTENSION
		if(File.exist?(path))
			File.delete(path)
		end
	end

	# donner description de la partie
	# retour : String
	def to_s()
		return "num:"+@numero.to_s()+" cont:"+@contenu+" ver:"+@verrou.to_s()+" comp:"+@compteur.to_s()+" mod:"+@modifiee.to_s()
	end
	  
	# verrouille la partie
	def verrouiller()
		@verrou = true
	end
	  
	# deverrouille la partie
	def deverrouiller()
		@verrou = false
	end
	  
	def modifier()
		# asbtraite
	end
	  
	def afficher()
		# asbtraite
	end
	  
	# donner le type de la partie
	# retour : Partie
	def type()
		return self.class.to_s()
	end
  
	# donner le nombre de commentaires sur la partie
	# retour : Fixnum
  	def nbCommentaires()
		return @commentaires.size()
	end
  
  
end
