# -*- coding: utf-8 -*-

require 'find'

#~ require('../kernel/Document.rb')
##############################################################################
# Projet L3 Groupe 2 : classe GestionnaireDocument
#
# ...
#
# dernière modification :	02/04/07, Romain
# todo : créer le répertoire PATH_DOCUMENTS s'il n'existe pas encore
##############################################################################
class GestionnaireDocument
      
        @@dernierNumeroDocument = 1	# Fixnum : le dernier numéro identifiant un document libre
      
	# permet l'utilisation de foreach
	 def GestionnaireDocument.eachDoc()
		Find.find(PATH_DOCUMENTS) { |chemin|
			monDoc = chemin.split(PATH_DOCUMENTS)[1]
			if monDoc != nil and id=monDoc.split("doc_")[1].split(".dat")[0]
				doc=Document.charger(id.to_i)
				yield(doc)
			end
		}
	end
	 
	# donne le premier identifiant de document libre
	# retour : Fixnum
	def GestionnaireDocument.donnerNumeroDocumentLibre()
		num = @@dernierNumeroDocument
		path = PATH_DOCUMENTS + "doc_" + num.to_s()+EXTENSION
		while(File.exist?(path))
			num = num + 1
			path = PATH_DOCUMENTS + "doc_" + num.to_s()+EXTENSION
		end
		@@dernierNumeroDocument = num + 1
		return  num
	end
	  
	# donner la partie 
	# retour : Partie
	def donnerPartie(idPartie)
		return @gestionnaireParties.donnerPartie(idPartie)
	end
	
	# donner le document
	# retour : Document
	def GestionnaireDocument.getDocument(id)
		return Document.charger(id.to_i)
	end

	# Supprimer un document
	def GestionnaireDocument.supprimerDocument(idDoc)	
		#on charge le document pour recuperer sa liste de version , les partie des version et les parties du document.
		doc=Document.charger(idDoc)
		listePart= Array.new()
		doc.eachPartie do |p|
			listePart.push(p)
		end
		
		listeVer=Array.new()	
		
		doc.listeVersions.each do |v| 
			version=Document.charger(idDoc,v)
			version.eachPartie do |p|
				listePart.push(p)
			end
			listeVer.push(v)
		end
		
		listeVer.each do |ver|
			path = PATH_VERSIONS + "ver_"+idDoc.to_s()+"_"+ver.to_s+EXTENSION
			if(File.exist?(path))
				File.delete(path)
			end
		end
		
		listePart.uniq!
		
		listePart.each do |p|
			p.supprimer()
		end
		
		# construire le path et vérifier que le fichier existe bien puis on supprime le document
		path = PATH_DOCUMENTS + "doc_"+idDoc.to_s()+EXTENSION
		if(File.exist?(path))
			File.delete(path)
		end
		
	end


	# donner les numéros de version et les dates correspondantes du document
	# retour : Hash
	def GestionnaireDocument.donnerDateDocument(id)
		doc = Document.charger(id)
		idToDate = Hash.new()
		doc.listeVersions.each do |idV|
			version = Document.charger(doc.numero, idV)
			if version != nil
				idToDate[idV] = version.dateDerniereModification
			end
		end
		return idToDate
	end
end
