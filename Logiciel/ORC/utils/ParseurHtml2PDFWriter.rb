# -*- coding: utf-8 -*-

##############################################################################
# Projet L3 Groupe 2 : parser de HTML vers PDFWriter
#
# 
#
# dernière modification :	11/04/06, Romain
##############################################################################

class ParseurHtml2PDFWriter
	
	
	def initialize()
		@baliseSouligne = "<u>"
		@baliseSouligneFerme = "</u>"
		@baliseBarre = "<s>"
		@baliseBarreFerme = "</s>"
	end
	
	def html2PDFWriter(texte)
		# souligné
		textePDF = (texte.include?(@baliseSouligne)) ? souligne2PDF(texte) : texte
		# barré
		textePDF = (textePDF.include?(@baliseBarre)) ?  barre2PDF(textePDF) : textePDF
		return textePDF
	end
	
	def souligne2PDF(texteHtml)
		return texteHtml.gsub(@baliseSouligne,"<c:uline>").gsub(@baliseSouligneFerme,"</c:uline>")
	end
	
	def barre2PDF(texteHtml)
		return texteHtml.gsub(@baliseBarre,"<c:s>").gsub(@baliseBarreFerme,"</c:s>")
	end
	
end

