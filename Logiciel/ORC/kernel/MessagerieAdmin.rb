# -*- coding: utf-8 -*-


##############################################################################
# Projet L3 Groupe 2 : classe MessagerieAdmin
#
# Messagerie qui contient les demandes d'inscriptions
#
# dernière modification :	11/04/07, Romain
##############################################################################

class MessagerieAdmin < Messagerie
	
	# charger la messagerie 
	# retour : MessagerieAdmin
	def chargerMessagerie()
		@lstMessages.clear()
		begin
		File.open(FICHIER_MESSAGERIE_ADMIN + EXTENSION,"r") do |f|
			@lstMessages = Marshal.load(f)
		end
		rescue 
			File.new(FICHIER_MESSAGERIE_ADMIN + EXTENSION,"w")
			self.enregistrerMessagerie()
		end
		return self
	end
		
	# recevoir un message
	# param message : Message
	# retour : Boolean
	def recevoirMessage(message)
		@lstMessages.values.each do |d|
			return false if d.expediteur == message.expediteur
		end
		super(message)
		self.enregistrerMessagerie()
		return true
	end
	
	# supprimer le message désigné par l'indice
	# param indice : Fixnum
	def supprimerMessage(indice)
		super(indice)
		self.enregistrerMessagerie()
	end
	
	# afficher le messagerie
	def afficherMessagerie()
		@lstMessages.each_value do |m| puts m end
	end
	
	# sérialiser la messagerie
	def enregistrerMessagerie()
		File.open(FICHIER_MESSAGERIE_ADMIN + EXTENSION,"w") do |f|
			Marshal.dump(@lstMessages,f)
		end
	end
	
	# permettre l'utilisation du foreach
	def each()
		@lstMessages.values.each{ |b| yield(b) }
	end
	
end
