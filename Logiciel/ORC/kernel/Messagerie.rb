# -*- coding: utf-8 -*-

##############################################################################
# Projet L3 Groupe 2 : classe Messagerie
#
# Messagerie d'un utilisateur
#
# dernière modification :	03/04/07, Romain
##############################################################################

class Messagerie
	
	@lstMessages     # Table de Hachage : la,liste des messages
	
	attr_reader :lstMessages
	
	#constructeur
	def initialize()
		@lstMessages = Hash.new()
		@dernierIdLibre = 0
	end
	
	#supression d'un message d'indice indice
	# param indice : Fixnum
	def supprimerMessage(indice)
		@lstMessages.delete(indice) if @lstMessages.has_key?(indice)
	end
	
	#reception d'un message
	# param message : Message
	def recevoirMessage(message)
		@lstMessages[message.id] = message
	end
	
	#Accès a un message d'indice indice
	# retour : Message
	def getMessage(indice)
		return @lstMessages[indice] if @lstMessages.has_key?(indice)
	end
	
	# incrémentation du compteur pour la création d'un nouveau message
	# retour : Fixnum
	def donneIdLibre()
		while @lstMessages.has_key?(@dernierIdLibre)
			@dernierIdLibre += 1
		end
		return @dernierIdLibre
	end
end
