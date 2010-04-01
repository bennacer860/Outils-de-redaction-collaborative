# -*- coding: utf-8 -*-

##############################################################################
# Projet L3 Groupe 2 : Initialisation
#
# On charge tous les fichiers d'un coup
# puis création d'un administrateur "admin" si inexistant
# et lancement du logiciel
#
# dernière modification :	11/04/07, Romain
##############################################################################

require "Parametres.rb"

require "kernel/Document.rb"
require "kernel/GestionnaireDocument.rb"
require "kernel/Partie.rb"
require "kernel/Paragraphe.rb"
require "kernel/Image.rb"
require "kernel/GestionnairePartie.rb"
require "kernel/Utilisateur.rb"
require "kernel/GestionnaireUtilisateur.rb"
require "kernel/Poubelle.rb"
require "kernel/Message.rb"
require "kernel/DemandeInscription.rb"
require "kernel/Messagerie.rb"
require "kernel/MessagerieAdmin.rb"
require "kernel/Commentaire.rb"

require "graphics/InterfaceActions.rb"
require "graphics/FenetreConnexion.rb"
require "graphics/FenetrePrincipale.rb"
require "graphics/FenetreInscription.rb"
require "graphics/FenetreMesDonnees.rb"
require "graphics/FenetreMessagerie.rb"
require "graphics/FenetreAdmin.rb"
require "graphics/FenetreNouveauDoc.rb"
require "graphics/FenetreOuvrirDoc.rb"
require "graphics/FenetreAuteur.rb"
require "graphics/FenetreExportPDF.rb"
require "graphics/FenetreExportWord.rb"
require "graphics/FenetreEditerImage.rb"
require "graphics/FenetreEditerParagraphe.rb"
require "graphics/FenetreEditerTexte.rb"
require "graphics/FenetreInsererPartie.rb"
require "graphics/FenetreCommenter.rb"
require "graphics/EventBoxModifImage.rb"
require "graphics/EventBoxModifParagraphe.rb"

require "utils/ParseurRsT2Html.rb"
require "utils/ParseurHtml2RsT.rb"
require "utils/ParseurHtml2PDFWriter.rb"
require "utils/PDFWriter.rb"
require "utils/Doc2Word.rb"
require "utils/utils.rb"


################

gestU = GestionnaireUtilisateur.new().chargerUtilisateurs()

if gestU.getUtilisateur("admin") == nil
	u = Utilisateur.creerContributeur("admin","admin","admin@gmail.com")
	u.devenirAdministrateur()
	gestU.ajouterUtilisateur(u)
end

FenetreConnexion.new()