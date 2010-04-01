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

class ParseurRsT2Html

	@baliseGras
	@baliseItalique
	@baliseSouligne
	@baliseBarre
	@balisePlusGros
	@balisePlusPetit
	@baliseTitre1
	@baliseTitre2
	attr_reader :baliseGras, :baliseItalique, :baliseSouligne, :baliseBarre, :balisePlusGros ,:balisePlusPetit ,:baliseTitre1 ,:baliseTitre2

	def initialize
		@baliseGras = "**"
		@baliseItalique = "//"
		@baliseSouligne = "__"
		@baliseBarre = "=="
		@balisePlusGros="++"
		@balisePlusPetit="--"
		@baliseTitre1="!!"
		@baliseTitre2="||"
	end

	def rsT2Html(texte)
		# gras
		texteHtml = (texte.include?(@baliseGras)) ? gras2Html(texte) : texte
		# italique
		texteHtml = (texteHtml.include?(@baliseItalique)) ? italique2Html(texteHtml) : texteHtml
		# souligné
		texteHtml = (texteHtml.include?(@baliseSouligne)) ? souligne2Html(texteHtml) : texteHtml
		# barré
		texteHtml = (texteHtml.include?(@baliseBarre)) ?  barre2Html(texteHtml) : texteHtml
		#plus gros
		texteHtml = (texteHtml.include?(@balisePlusGros)) ?  gros2Html(texteHtml) : texteHtml
		#plus petit
		texteHtml = (texteHtml.include?(@balisePlusPetit)) ?  petit2Html(texteHtml) : texteHtml
		#Titre 1
		texteHtml = (texteHtml.include?(@baliseTitre1)) ?  titre12Html(texteHtml) : texteHtml
		#Titre 2
		texteHtml = (texteHtml.include?(@baliseTitre2)) ?  titre22Html(texteHtml) : texteHtml
		return texteHtml
	end
	
	def titre22Html(texteRsT)
		texteHtml = ""
		debut = true
		texteRsT.each(@baliseTitre2) do |tok|
			texteHtml += (debut == true)? tok.gsub(@baliseTitre2, '<span size="xx-large">') : tok.gsub(@baliseTitre2, '</span>')
			debut = (debut == true)? false : true 
		end
		return texteHtml
	end
	
	def titre12Html(texteRsT)
		texteHtml = ""
		debut = true
		texteRsT.each(@baliseTitre1) do |tok|
			texteHtml += (debut == true)? tok.gsub(@baliseTitre1, '<span size="x-large">') : tok.gsub(@baliseTitre1, '</span>')
			debut = (debut == true)? false : true 
		end
		return texteHtml
	end
	
	def gras2Html(texteRsT)
		texteHtml = ""
		debut = true
		texteRsT.each(@baliseGras) do |tok|
			texteHtml += (debut == true)? tok.gsub(@baliseGras, '<b>') : tok.gsub(@baliseGras, '</b>')
			debut = (debut == true)? false : true 
		end
		return texteHtml
	end

	def italique2Html(texteRsT)
		texteHtml = ""
		debut = true
		texteRsT.each(@baliseItalique) do |tok|
			texteHtml += (debut == true)? tok.gsub(@baliseItalique, '<i>') : tok.gsub(@baliseItalique, '</i>')
			debut = (debut == true)? false : true 
		end
		return texteHtml
	end
	
	def souligne2Html(texteRsT)
		texteHtml = ""
		debut = true
		texteRsT.each(@baliseSouligne) do |tok|
			texteHtml += (debut == true)? tok.gsub(@baliseSouligne, '<u>') : tok.gsub(@baliseSouligne, '</u>')
			debut = (debut == true)? false : true 
		end
		return texteHtml
	end
	
	def barre2Html(texteRsT)
		texteHtml = ""
		debut = true
		texteRsT.each(@baliseBarre) do |tok|
			texteHtml += (debut == true)? tok.gsub(@baliseBarre, '<s>') : tok.gsub(@baliseBarre, '</s>')
			debut = (debut == true)? false : true 
		end
		return texteHtml
	end
	
	def petit2Html(texteRsT)
		texteHtml = ""
		debut = true
		texteRsT.each(@balisePlusPetit) do |tok|
			texteHtml += (debut == true)? tok.gsub(@balisePlusPetit, '<small>') : tok.gsub(@balisePlusPetit, '</small>')
			debut = (debut == true)? false : true 
		end
		return texteHtml
	end
	
	def gros2Html(texteRsT)
		texteHtml = ""
		debut = true
		texteRsT.each(@balisePlusGros) do |tok|
			texteHtml += (debut == true)? tok.gsub(@balisePlusGros, '<big>') : tok.gsub(@balisePlusGros, '</big>')
			debut = (debut == true)? false : true 
		end
		return texteHtml
	end
	
end


