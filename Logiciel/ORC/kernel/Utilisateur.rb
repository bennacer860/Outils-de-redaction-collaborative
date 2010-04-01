# -*- coding: utf-8 -*-

##############################################################################
# Projet L3 Groupe 2 : classe Utilisateur
#
# L'utilisateur du système
#
# dernière modification :	02/04/07, Romain
##############################################################################
class Utilisateur
	
	@nom		# String : le nom identifiant l'utilisateur
	@motDePasse # String : le mot de passe <= un condensé MD5 ça ne serait pas du luxe !
	@eMail		# String : l'adresse email
	@statut		# String : constante définie dans Parametres.rb
	@messagerie	#Messagerie
	
	attr_reader :nom
	attr_reader :motDePasse
	attr_reader :messagerie
	attr_reader :eMail
	attr_reader :statut
	
	# construire un utilisateur, (contributeur)
	# param nom : String
	# param mot : String
	# param email : String
	def Utilisateur.creerContributeur(nom, mot, email)
		Utilisateur.new(nom, mot, email, STATUT_CONTRIBUTEUR,Messagerie.new())
	end

	# construire un utilisateur, (visiteur)
	def Utilisateur.creerVisiteur()
		Utilisateur.new(nom = "anonyme", mot = "", email = "", statut = STATUT_VISITEUR,messagerie = nil)
	end
	
	# charger l'utilisateur
	# param nom : String
	# retour : Utilisateur
	def Utilisateur.charger(nom)
		path = PATH_UTILISATEURS+  nom.downcase() + EXTENSION
		if(!File.exist?(path))
			return nil
		else
			f = File.new(path,"r")
			utilisateur = Marshal.load(f)
			f.close()
			return utilisateur
		end
	end
	
	# enregistrer l'utilisateur
	def enregistrer()
		# construire le path
		path = PATH_UTILISATEURS + @nom.downcase()+EXTENSION
		# ouvrir le fichier en écriture et écrire les informations
		fichierSerialise = File.new(path,"w") 
		Marshal.dump(self,fichierSerialise)
		fichierSerialise.close()
	end

	# initialiser l'utilisateur
	# param nom : String
	# param mot : String
	# param email : String
	# param statut : String 
	# param messagerie : Messagerie
	def initialize(nom, mot, email, statut,messagerie)
		@nom, @motDePasse, @eMail, @statut, @messagerie =  nom, mot, email, statut,messagerie
	end

	# vérifier si l'utilisateur est visiteur
	# retour : Boolean la réponse
	def estVisiteur?()
		return @statut == STATUT_VISITEUR
	end

	# vérifier si l'utilisateur est contributeur
	# retour : Boolean la réponse
	def estContributeur?()
		return @statut == STATUT_CONTRIBUTEUR
	end

	# vérifier si l'utilisateur est auteur
	# retour : Boolean la réponse
	def estAuteur?()
		return @statut == STATUT_AUTEUR
	end

	# vérifier si l'utilisateur est administrateur
	# retour : Boolean la réponse
	def estAdministrateur?()
		return @statut == STATUT_ADMINISTRATEUR
	end

	# affecter le statut auteur à un contributeur
	def devenirContributeur()
		if estVisiteur?()
			raise("Un visiteur ne peut devenir contributeur")
		else
			@statut = STATUT_CONTRIBUTEUR
			enregistrer()
		end
		return self
	end

	# affecter le statut auteur à un contributeur
	def devenirAuteur()
		if estVisiteur?()
			raise("Un visiteur ne peut devenir auteur")
		else
			@statut = STATUT_AUTEUR
			enregistrer()
		end
		return self
	end
	
	# affecter le statut administrateur à un contributeur
	def devenirAdministrateur()
		if estVisiteur?()
			raise("Un visiteur ne peut devenir administrateur")
		else
			@statut = STATUT_ADMINISTRATEUR
			enregistrer()
		end
		return self
	end

	# afficher la description de l'utilisateur
	# retour : String
	def to_s()
		return @nom+" est un "+@statut
	end
	
	#donne une liste des documents accessibles
	#retour liste de documents
	def donnerDocumentsAccessibles()
		listeDocs = Array.new
		GestionnaireDocument.eachDoc() do |doc|
			if doc.estPublic?()
				listeDocs.push(doc)
			elsif doc.auteur != nil && doc.auteur.nom==self.nom
				listeDocs.push(doc)
			else
				doc.listeContributeurs.compact.each do |contrib|
					if contrib.nom == self.nom
						listeDocs.push(doc)
					end
				end
			end
		end
		return listeDocs
	end
	
	#donne une liste des documents créés
	#retour liste de documents
	def donnerDocumentsCrees()
		listeDocs = Array.new
		GestionnaireDocument.eachDoc() do |doc|
			if doc.auteur != nil && doc.auteur.nom== self.nom
				listeDocs.push(doc)
			end
		end
		return listeDocs
	end
	
	#modifie l'email et le mot de passe de l'utilisateur
	# param mail : String
	# param mdp : String
	def modifierDonnees(mail, mdp)
		@eMail=mail
		@motDePasse=mdp
		enregistrer()
		return self
	end
	
	# comparer avec un autre utilisateur
	# param unUtilisateur : Utilisateur
	def ==(unUtilisateur)
		return false if unUtilisateur == nil
		return self.nom == unUtilisateur.nom()
	end

end
