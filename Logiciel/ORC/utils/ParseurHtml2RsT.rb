# -*- coding: utf-8 -*-

##############################################################################
# Projet L3 Groupe 2 : parser de RestructuredText Markup
#
# 
#
# dernière modification :	04/04/06, beber
##############################################################################

# sources :
# http://docutils.sourceforge.net/sandbox/wilk/french/quickstart-fr.html
# http://docutils.sourceforge.net/docs/user/rst/quickref.html

# italique		//texte//		<i>italic</i>
# gras 		**texte**		<b>bold</b>
# souligné	         __texte__      	<u>souligne</u>
# barré 		\\texte\\    	  	<s>strike</s>    
# petit 		--texte-- 		<small>petit</small>
# grand 		++texte++ 		<big>grand</big>
# Titre1 		!!texte!! 		<span size="xx-large">Titre1</span>
# Titre2 		||texte|| 		<span size="x-large">Titre2</span>

class ParseurHtml2RsT

	@baliseGras
	@baliseGrasFerme
	@baliseItalique
	@baliseItaliqueFerme
	@baliseSouligne
	@baliseSouligneFerme
	@baliseBarre
	@baliseBarreFerme
	@balisePlusGros
	@balisePlusGrosFerme
	@balisePlusPetit
	@balisePlusPetitFerme
	@baliseTitre1
	@baliseTitre1Ferme
	@baliseTitre2
	@baliseTitre2Ferme
	attr_reader :baliseGras, :baliseItalique, :baliseSouligne, :baliseBarre, :balisePlusGros ,:balisePlusPetit ,:baliseTitre1 ,:baliseTitre2 ,:baliseGrasFerme, :baliseItaliqueFerme ,:baliseSouligneFerme ,:baliseBarreFerme ,:balisePlusGrosFerme ,:balisePlusPetitFerme, :baliseTitre1Ferme ,:baliseTitre2Ferme 
	def initialize
		@baliseGras="<b>"
		@baliseGrasFerme="</b>"
		@baliseItalique="<i>"
		@baliseItaliqueFerme="</i>"
		@baliseSouligne="<u>"
		@baliseSouligneFerme="</u>"
		@baliseBarre="<s>"
		@baliseBarreFerme="</s>"
		@balisePlusGros="<big>"
		@balisePlusGrosFerme="</big>"
		@balisePlusPetit="<small>"
		@balisePlusPetitFerme="</small>"
		@baliseTitre1 ="<span size=\"x-large\">"
		@baliseTitre1Ferme="</span>"
		@baliseTitre2 ="<span size=\"xx-large\">"
		@baliseTitre2Ferme="</span>"
	end

	def html2RsT(texte)
		# gras
		texteRsT = (texte.include?(@baliseGras)) ? gras2RsT(texte) : texte
		# italique
		texteRsT = (texteRsT.include?(@baliseItalique)) ? italique2RsT(texteRsT) : texteRsT
		# souligné
		texteRsT = (texteRsT.include?(@baliseSouligne)) ? souligne2RsT(texteRsT) : texteRsT
		# barré
		texteRsT = (texteRsT.include?(@baliseBarre)) ?  barre2RsT(texteRsT) : texteRsT
		#plus gros
		texteRsT = (texteRsT.include?(@balisePlusGros)) ?  gros2RsT(texteRsT) : texteRsT
		#plus petit
		texteRsT = (texteRsT.include?(@balisePlusPetit)) ?  petit2RsT(texteRsT) : texteRsT
		#Titre 1
		texteRsT = (texteRsT.include?(@baliseTitre1)) ?  titre12RsT(texteRsT) : texteRsT
		#Titre 2
		texteRsT = (texteRsT.include?(@baliseTitre2)) ?  titre22RsT(texteRsT) : texteRsT
		return texteRsT
	end
	
	def titre22RsT(texteHtml)
		texteRsT = texteHtml.gsub(@baliseTitre2,'||').gsub(@baliseTitre2Ferme,'||')
		return texteRsT
	end
	
	def titre12RsT(texteHtml)
		texteRsT = texteHtml.gsub(@baliseTitre1,'!!').gsub(@baliseTitre1Ferme,'!!')
		return texteRsT
	end
	
	def gras2RsT(texteHtml)
		texteRsT = texteHtml.gsub(@baliseGras,'**').gsub(@baliseGrasFerme,'**')
		return texteRsT
	end

	def italique2RsT(texteHtml)
		texteRsT = texteHtml.gsub(@baliseItalique,'//').gsub(@baliseItaliqueFerme,'//')
		return texteRsT
	end
	
	def souligne2RsT(texteHtml)
		texteRsT = texteHtml.gsub(@baliseSouligne,'__').gsub(@baliseSouligneFerme,'__')
		return texteRsT
	end
	
	def barre2RsT(texteHtml)
		texteRsT = texteHtml.gsub(@baliseBarre,'==').gsub(@baliseBarreFerme,'==')
		return texteRsT
	end
	
	def petit2RsT(texteHtml)
		texteRsT = texteHtml.gsub(@balisePlusPetit,'--').gsub(@balisePlusPetitFerme,'--')
		return texteRsT
	end
	
	def gros2RsT(texteHtml)
		texteRsT = texteHtml.gsub(@balisePlusGros,'++').gsub(@balisePlusGrosFerme,'++')
		return texteRsT
	end
	
end


