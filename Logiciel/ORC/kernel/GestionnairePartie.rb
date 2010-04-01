# -*- coding: utf-8 -*-

##############################################################################
# Projet L3 Groupe 2 : classe GestionnairePartie
#
# ...
#
# dernière modification :	25/03/07
# todo : créer le répertoire PATH_PARTIES s'il n'existe pas encore
##############################################################################
class GestionnairePartie
	
	@@dernierNumeroPartie = 1	# Fixnum : le dernier numéro de partie attribué
	
	# donner le premier numéro de partie libre
	# retour : Fixnum, le numéro
	def GestionnairePartie.donnerNumeroPartieLibre()
		num = @@dernierNumeroPartie
		path = PATH_PARTIES + "part_" + num.to_s()+EXTENSION
		while(File.exist?(path))
			num = num + 1
			path = PATH_PARTIES + "part_" + num.to_s()+EXTENSION
		end
		@@dernierNumeroPartie = num + 1
		return  num
	end
	
end
