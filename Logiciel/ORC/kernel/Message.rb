# -*- coding: utf-8 -*-
##############################################################################
# Projet L3 Groupe 2 : classe Message
#
# Message inclus dans la messagerie
#
# dernière modification :	03/04/07, Romain
##############################################################################
class Message
	
	@expediteur	# String : Expediteur du message
	@message	# String : Contenu du message
	@statut		# Boolean : Si le message a été lu ou pas
	@id			# Indice du message dans la messagerie
	# Les getteurs
	attr_reader :message,:statut,:expediteur,:id
	
	# Constructeur
	# param id : Fixnum
	# param exp : String
	# param mess : String
	def initialize(id,exp,mess)
		@id,@expediteur,@message,@statut = id,exp,mess,false
	end
	
	# Changement du statut d'un message il devient lu
	# retour : Message
	def changerStatut()
		@statut=true
		return self
	end
	
end
