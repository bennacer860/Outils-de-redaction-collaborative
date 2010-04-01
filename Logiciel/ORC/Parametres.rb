# -*- coding: utf-8 -*-
##############################################################################
# Projet L3 Groupe 2 : fichier de paramètrages du système
#
# contient tous les paramètres et réglages d'environnement du syst�me
#
# dernière modification :	30/03/06, Romain
##############################################################################
require 'gtk2'

# constante path de sauvegarde des fichiers
PATH = "tmp/"
PATH_UTILISATEURS = "tmp/utilisateurs/"	# <= voir selon OS ?
PATH_PARTIES = "tmp/parties/"
PATH_DOCUMENTS = "tmp/documents/"
PATH_VERSIONS = "tmp/versions/"
PATH_IMAGES = "images/"
FICHIER_MESSAGERIE_ADMIN = "tmp/messagerie/mess_admin"
EXTENSION = ".dat"
SEPARATEUR = "~"

# constantes fixant les statuts des utilisateurs
STATUT_VISITEUR = "visiteur"
STATUT_CONTRIBUTEUR = "contributeur"
STATUT_AUTEUR = "auteur"
STATUT_ADMINISTRATEUR = "administrateur"
STATUTS = [STATUT_CONTRIBUTEUR,STATUT_AUTEUR,STATUT_ADMINISTRATEUR]

# constantes pour les couleurs
COULEUR_SELECTIONNE = Gdk::Color.new(55000 , 65535, 55000)
COULEUR_DESELECTIONNE = Gdk::Color.new(65535,65535,65535)

# constante numero de version
VERSION_LOG = "2007"

#constante des tailles de police pour l'exportation
TAILLE_TITRE_DOCUMENT = 48
TAILLE_DESCRIPTIF = 22
TAILLE_TITRE_PARTIE = 16
TAILLE_PARAGRAPHE = 12
