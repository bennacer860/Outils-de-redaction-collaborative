# -*- coding: utf-8 -*-

require 'find'
##############################################################################
# Projet L3 Groupe 2 : classe GestionnaireUtilisateur
#
# Le gestionnaire des utilisateurs du système
#
# dernière modification :	02/04/07, Romain
#
# todo  : initialize() : créer le répertoire PATH_UTILISATEURS s'il n'existe pas encore
##############################################################################
class GestionnaireUtilisateur
	
	@utilisateurs	# Array : les utilisateurs du système
	
	# initialiser la poubelle
	def initialize()
		@utilisateurs = Array.new()
	end
	
	# charger la liste des utilisateurs du système
	def chargerUtilisateurs()
		# vider le tableau d'utilisateurs
		@utilisateurs.clear()
		# parcourir le répertoire PATH_UTILISATEURS et charger chaque fichier utilisateur
		Find.find(PATH_UTILISATEURS) do |pathFichier|
			if pathFichier != PATH_UTILISATEURS
				fichierSerialise = File.new(pathFichier,"r")
				@utilisateurs.push(Marshal.load(fichierSerialise))
				fichierSerialise.close()
			end
		end
		return self
	end
	
	# ajouter l'utilisateur
	# param utilisateur : Utilisateur
	def ajouterUtilisateur(utilisateur)
		utilisateur.enregistrer()
		@utilisateurs.push(utilisateur)
	end
	
	# supprimer l'utilisateur
	# param nom : String, le nom de l'utilisateur
	def supprimerUtilisateur(nom)
		# construire le path et vérifier que le fichier existe bien
		path = PATH_UTILISATEURS + nom.downcase()+EXTENSION
		if(!File.exist?(path))
			raise("le fichier sérialisé de l'utilisateur n'existe pas !")
		else
			File.delete(path)
			@utilisateurs.each do |utilisateur|
				if utilisateur.nom() == nom
					@utilisateurs.delete(utilisateur)
					break
				end
			end
		end
	end
	
	# donner l'utilisateur
	# param nom : String
	def getUtilisateur(nom)
		return Utilisateur.charger(nom)
	end
	
	# donner la liste des noms d'utilisateurs
	# retour : Array liste des noms
	def donnerUtilisateurs()
		utilisateurs = Array.new()
		@utilisateurs.each do |utilisateur| 
				utilisateurs.push(utilisateur.nom())
		end
		return utilisateurs.sort()
	end
	
	# donner la liste des noms de contributeurs potentiels
	# retour : Array liste des noms
	def donnerContributeurs()
		contributeurs = Array.new()
		@utilisateurs.each do |utilisateur| 
			if utilisateur.estContributeur?() or utilisateur.estAuteur?() 
				contributeurs.push(utilisateur.nom())
			end
		end
		return contributeurs.sort()
	end

	# donner la liste des noms d'auteurs
	# retour : Array liste des noms
	def donnerAuteurs()
		auteurs = Array.new()
		@utilisateurs.each do |utilisateur| 
			if utilisateur.estAuteur?() 
				auteurs.push(utilisateur.nom())
			end
		end
		return auteurs.sort()
	end
	
	
	# donner la liste des noms d'administrateurs
	# retour : Array liste des noms
	def donnerAdministrateurs()
		administrateurs = Array.new()
		@utilisateurs.each do |utilisateur| 
			if utilisateur.estAdministrateur?() 
				administrateurs.push(utilisateur.nom())
			end
		end
		return administrateurs.sort()
	end

	# afficher tous les utilisateurs connus
	# retour : String
	def to_s()
		contenu = ""
		@utilisateurs.each do |utilisateur| 
			contenu = contenu + utilisateur.to_s()+"\n"
		end
		return contenu
	end
	
	# permettre l'utilisation du foreach
	def each()
		@utilisateurs.compact().each do |b| yield(b) end
	end
	
end
