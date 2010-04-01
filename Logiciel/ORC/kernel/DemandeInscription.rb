# -*- coding: utf-8 -*-

##############################################################################
# Projet L3 Groupe 2 : classe DemandeInscription
#
# Les demandes d'inscription (création de compte)
#
# dernière modification :	11/04/07, Romain
##############################################################################



class DemandeInscription < Message
	
	@statutDemande	# String : le statut demandée par le visiteur
	@mail			# String : l'e-mail du demandeur
	@motDePasse		# String : le mot de passe choisi
	attr_reader :statutDemande,:mail,:motDePasse
	
	# initialiser la nouvelle demande d'inscription
	# param id : Fixnum
	# param expediteur : String
	# param motDePasse : String
	# param mail : String
	# param message : String
	# param statutDemande : String
	def initialize(id,expediteur,motDePasse,mail,message,statutDemande)
		super(id,expediteur,message)
		@statutDemande = statutDemande
		@mail = mail
		@motDePasse = motDePasse
	end
	
	# donner la description de la demande
	# retour : String
	def to_s()
		return "Demande inscription n°#{@id} : #{@expediteur},#{@motDePasse},#{@mail},#{@statutDemande},#{@message}"
	end
end
