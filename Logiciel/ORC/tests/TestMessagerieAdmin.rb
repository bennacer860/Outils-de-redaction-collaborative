# -*- coding: utf-8 -*-
require('../Parametres.rb')
require('../kernel/MessagerieAdmin.rb')
require('../kernel/DemandeInscription.rb')
##############################################################################
# Projet L3 Groupe 2 : Test Unitaire de la classe MessagerieAdmin
#
# Teste les méthodes et fonctionnalités de la classe MessagerieAdmin
#
# dernière modification :	11/04/07, N. Dupont
##############################################################################
messagerieA = MessagerieAdmin.new()
messagerieA.chargerMessagerie()
dem1 = DemandeInscription.new(1,"moi","pouic","moi@gmail.com","mon contenu de demande",STATUT_CONTRIBUTEUR)
messagerieA.recevoirMessage(dem1)
messagerieA.afficherMessagerie()
