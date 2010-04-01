# -*- coding: utf-8 -*-
require 'date'

##############################################################################
# Projet L3 Groupe 2 : classe Document
#
# L'objet de travail basique
#
# dernière modification :	30/03/07
# todo : dissocier le chargement de l'interface du doc et celui de ses parties
##############################################################################

class Document
	
	@numero					# Fixnum : le numéro identifiant le document
	@numeroVersion			# Fixnum : le numéro de version du document
	@titre					# String : le titre du document
	@visibilitePublique			# Boolean : le document est visible par tous ?
	@dateDerniereModification	# Date : la date de dernière modification
	@descriptif				# String : le descriptif
	@listeParties				# Array : la liste des parties
	@auteur					# Utilisateur : l'auteur du document
	@listeContributeurs			# Array : les contributeurs du document
	@listeVersions				# Array : les numéros des versions
	@poubelle				# Poubelle : la poubelle
  
	attr_reader :dateDerniereModification
	attr_reader :numero
	attr_reader :numeroVersion
	attr_reader :auteur
	attr_reader :listeVersions
	attr_reader :listeContributeurs
	attr_reader :descriptif
	attr_accessor :titre
	attr_accessor :visibilitePublique
	attr_accessor :listeParties
  
	# construire un nouveau document
	# param num : Fixnum
	# param tit : String
	# param vis : Boolean
	# param desc : String
	# param aut : Utilisateur
	# param contr : Array
	# param lstParties : Array
	# param lstVersions : Array
	# param date : Date 
	def Document.creer(num, tit, vis, desc,aut,contr = Array.new(),lstParties = Array.new(),lstVersions = Array.new().push(1),date = Date.today())
		new(num, tit, vis, desc,aut,contr,lstParties,lstVersions,date)
	end
	
	# initialiser le nouveau document
	# param num : Fixnum
	# param tit : String
	# param vis : Boolean
	# param desc : String
	# param aut : Utilisateur
	# param contr : Array
	# param lstParties : Array
	# param lstVersions : Array
	# param date : Date 
	def initialize(num, tit, vis, desc,aut,contr,lstParties,lstVersions,date)
		@numero, @titre, @visibilitePublique, @descriptif, @auteur, @listeContributeurs = num, tit, vis, desc,aut,contr
		@listeVersions = lstVersions
		@numeroVersion = @listeVersions.sort().last()
		@dateDerniereModification = date
		@listeParties = lstParties
		@poubelle = Poubelle.new()
	end
	
	# charger la version du document (la dernière par défaut)
	# param numero : FixNum
	# param version : FixNum
	# retour : Document
	def Document.charger(numero, version = 0)
		# charger fichier doc
		pathDoc = PATH_DOCUMENTS+ "doc_" + numero.to_s()+ EXTENSION
		if File.exists?(pathDoc)
			File.open(pathDoc,"r") do |f|
				listeVersions = Marshal.load(f)
				numero = Marshal.load(f)
				titre = Marshal.load(f)
				descriptif = Marshal.load(f)
				visibilitePublique = Marshal.load(f)	
				nomAuteur = Marshal.load(f)
				auteur = Utilisateur.charger(nomAuteur)
				nomContributeurs = Marshal.load(f)
				contributeurs = Array.new()
				nomContributeurs.each do |nom|
					contributeurs.push(Utilisateur.charger(nom))
				end
				# charger le fichier version
				if version == 0
					version = listeVersions.sort().last()
				end
				pathVersion = PATH_VERSIONS+ "ver_" + numero.to_s() + "_" + version.to_s()+ EXTENSION
				File.open(pathVersion,"r") do |fv|
					date = Marshal.load(fv)			
					numeroParties = Marshal.load(fv)
					# charger les parties
					parties = Array.new()
					numeroParties.each do |numPartie|
						parties.push(Partie.charger(numPartie))
					end
					# construire le document
					doc = Document.creer(numero, titre, visibilitePublique, descriptif,auteur,contributeurs,parties,listeVersions, date)
					return doc
				end
			end
		end
		return nil
	end
	
	
	
	# insérer la partie après la partie précédente
	# param partie : Partie
	# param partiePrecedente : Partie
	def insererPartieApres(partie, partiePrecedente)
		if(partiePrecedente == nil)
			@listeParties.push(partie)
		else
			pos = @listeParties.index(partiePrecedente)
			@listeParties.size.downto(pos+1) do |n|
				@listeParties[n] = @listeParties[n-1]
			end
			@listeParties[pos+1] = partie
		end
	end
	
	# retirer la partie
	# param partie : Partie
	def retirerPartie(partie)
		@listeParties.each do |part|
			if partie == part
				@poubelle.ajouterPartie(partie)
				partie.decrementerCompteur()
				@listeParties.delete(partie)
				@listeParties.compact!()
				break
			end
		end
	end
	
	# monter une partie
	# param partie : Partie
	# retour : Vrai si la partie a pu etre montee, faux sinon
	def monterPartie(partie)
		position = @listeParties.index(partie)
		if position != 0
			tmp = @listeParties[position - 1]
			@listeParties[position - 1] = partie
			@listeParties[position] = tmp
			return true
		end
		return false
	end
  
	# descendre une partie
	# param partie : Partie
	# retour : Vrai si la partie a pu etre descendue, faux sinon
	def descendrePartie(partie)
		position = @listeParties.index(partie)
		if position != @listeParties.size() - 1
			tmp = @listeParties[position + 1]
			@listeParties[position + 1] = partie
			@listeParties[position] = tmp
			return true
		end
		return false
	end
  
	# ajouter le contributeur
	# param utilisateur : Utilisateur
	def ajouterContributeur(utilisateur)
		@listeContributeurs.push(utilisateur)
	end

	# retirer le contributeur
	# param utilisateur : Utilisateur
	def retirerContributeur(utilisateur)
		@listeContributeurs.each do |util|
			if utilisateur == util
				@listeContributeurs.delete(utilisateur)
				break
			end
		end
	end

	# enregistrer le document
	def enregistrer()
		# enregistrer fichier doc
		pathDoc = PATH_DOCUMENTS+ "doc_" + @numero.to_s()+ EXTENSION
		nomContributeurs = Array.new()
		@listeContributeurs.compact().each do |cont|
			nomContributeurs.push(cont.nom())
		end
		File.open(pathDoc,"w") do |f|
			Marshal.dump(@listeVersions,f)
			Marshal.dump(@numero,f)
			Marshal.dump(@titre,f)
			Marshal.dump(@descriptif,f)
			Marshal.dump(@visibilitePublique,f)
			Marshal.dump(@auteur.nom(),f)
			Marshal.dump(nomContributeurs, f)
		end
		# enregistrer fichier version
		pathVersion = PATH_VERSIONS+ "ver_" + @numero.to_s() + "_" + @numeroVersion.to_s()+ EXTENSION
		numeroParties = Array.new()
		@listeParties.compact().each do |part|
			numeroParties.push(part.numero())
		end
		File.open(pathVersion,"w") do |f|
			Marshal.dump(@dateDerniereModification,f)			
			Marshal.dump(numeroParties,f)
		end
		# enregistrer parties
		@listeParties.compact().each do |partie|
			partie.enregistrer()
		end
		# vider poubelle
		@poubelle.vider()
	end
	
	# enregistrer une version
	def enregistrerVersion()
		self.creerVersion()
		self.enregistrer()
	end
	
	# créer une nouvelle version du document
	def creerVersion()
		# récupérer le dernier numéro de version utilisé
		@numeroVersion = @listeVersions.sort().last() + 1
		@listeVersions.push(@numeroVersion)
		@dateDerniereModification = Date.today()
		@listeParties.compact().each do |partie|
			partie.incrementerCompteur()
		end
	end
	
	# donner l'historique
	def donnerHistorique()
		return @listeVersions
	end	
	
	# retourner la description du document
	# retour : String
	def to_s()
		str = "num:"+@numero.to_s()+" numV:"+@numeroVersion.to_s()+" tit:"+@titre+" vis:"+@visibilitePublique.to_s()+" date:"+@dateDerniereModification.to_s()+" desc:"+@descriptif+"\n"
		str = str +"auteur : \n"+ @auteur.to_s() +"\n"
		str = str + "contributeurs : \n"
		@listeContributeurs.each do |contr|
			str = str + contr.to_s() + "\n"
		end
		@listeParties.each do |partie|
			str = str +partie.to_s()+"\n"
		end
		return str
	end
	
	# permettre l'utilisation du eachPartie | bloc de code |
	def eachPartie()
		@listeParties.compact!
		for item in @listeParties
			yield(item) # yield exécute le bloc appelant
		end
	end
	
	# changer l'auteur
	# param auteur : Utilisateur
	def changerAuteur(auteur)
		@auteur = auteur
		self.enregistrer()
		return self
	end
	
	# vérifier si le document est public
	# retour : Boolean
	def estPublic?()
		return @visibilitePublique
	end
	
end
