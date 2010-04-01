# -*- coding: utf-8 -*-
require('../kernel/Message.rb')
##############################################################################
# Projet L3 Groupe 2 : Test Unitaire de la classe Message
#
# Teste les méthodes et fonctionnalités de la classe Message
#
# dernière modification :	11/04/07, N. Dupont
##############################################################################
mes = Message.new(1,"Moi","Salut toi")
puts mes.statut()
mes.changerStatut()
puts mes.statut()