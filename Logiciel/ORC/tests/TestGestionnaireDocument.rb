# -*- coding: utf-8 -*-
require("../kernel/Document.rb")
require("../kernel/GestionnaireDocument.rb")
##############################################################################
# Projet L3 Groupe 2 : Test Unitaire de la classe GestionnaireDocument
#
# Teste les méthodes et fonctionnalités de la classe GestionnaireDocument
#
# dernière modification :	11/04/07, N. Dupont
##############################################################################

GestionnaireDocument.eachDoc do |doc|
	puts doc
end
puts GestionnaireDocument.donnerNumeroDocumentLibre()
puts GestionnaireDocument.getDocument(1)
puts GestionnaireDocument.donnerDateDocument(1)