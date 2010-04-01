# -*- coding: utf-8 -*-
require('../kernel/Messagerie.rb')
require('../kernel/Message.rb')
##############################################################################
# Projet L3 Groupe 2 : Test Unitaire de la classe Messagerie
#
# Teste les méthodes et fonctionnalités de la classe Messagerie
#
# dernière modification :	11/04/07, N. Dupont
##############################################################################
messagerie = Messagerie.new()
num = messagerie.donneIdLibre()
mes = Message.new(num,"Moi","Salut toi")
messagerie.recevoirMessage(mes)
puts messagerie.getMessage(num)
messagerie.supprimerMessage(mes)