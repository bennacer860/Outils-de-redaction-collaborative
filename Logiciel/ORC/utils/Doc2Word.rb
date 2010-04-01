# -*- coding: utf-8 -*-

##############################################################################
# Projet L3 Groupe 2 : 
##############################################################################


class Doc2Word
	
	@word 					#Win32OLE : l'objet Word
	@justification 			#Hash : gestion de la justification du texte
	
	def initialize()
		
		@word = WIN32OLE.new('word.application')
		@word.Visible = true
		@word.Documents.Add
		
		@justification = {
			"A gauche" => 0,
			"Centrer" => 1,
			"A droite" => 2,
			"Justifier" => 3
		}
	end
	
	#ajouter du texte
	# param font : String
	# param texte : String
	# param couleur : Gdk::Color
	# param position : String
	def ajouterTexte(font,texte,couleur,position)
		texte = GLib.convert(texte, "ISO-8859-15", "UTF-8")    #Conversion de l'UTF8 vers ISO-8859-15
		position = @justification[position]
		
		r = couleur.red.to_i / 256
		v = couleur.green.to_i / 256
		b = couleur.blue.to_i / 256
		
		valeur = ((b * 256) + v) * 256 + r	
		
		
		f = font.split()
		
		taille = f.pop().to_i
		stylePolice = f.pop() if f.include?("Bold") || f.include?("Italic") || f.include?("Bold Italic")
		police = f.join(" ")
		
		tailleDefaut = taille
		
		tab = []
		
		r = %r{(<big>.*</big>)|(<small>.*</small>)|(<span size=.*>.*</span>)}
		texte.split(r).each do |c|
			if %r{<big>(.*)</big>}.match(c)
				texte = $1
				taille = tailleDefaut + 2
			elsif %r{<small>(.*)</small>}.match(c)
				texte = $1
				taille = tailleDefaut - 2
			elsif %r{<span size=\"(x{1,2})-large\">(.*)</span>}.match(c)
				case $1
					when "x"
						taille = 22
					when "xx"
						taille = 26
				end
				texte = $2
			else
				taille = tailleDefaut
				texte = c
			end
			tab << [texte,taille]
		end
	
		re = %r{(<u>.*</u>)|(<b>.*</b>)|(<i>.*</i>)|(<s>.*</s>)}
		tab.each do |t|
			t[0].split(re).each do |d|
				if %r{<u>(.*)</u>}.match(d)
					s = $1
					@word.Selection.Font.Underline = true
				elsif %r{<b>(.*)</b>}.match(d)
					s = $1
					@word.Selection.Font.Bold = true
				elsif %r{<i>(.*)</i>}.match(d)
					s = $1
					@word.Selection.Font.Italic = true
				elsif %r{<s>(.*)</s>}.match(d)
					s = $1
					@word.Selection.Font.StrikeThrough = true
				else
					s = d
					@word.Selection.Font.Underline = false
					@word.Selection.Font.Bold = false
					@word.Selection.Font.Italic = false
					@word.Selection.Font.StrikeThrough = false
				end
				
				@word.Selection.Font.Bold = true if stylePolice == "Bold" || stylePolice == "Bold Italic"
				@word.Selection.Font.Italic = true if stylePolice == "Italic" || stylePolice == "Bold Italic"
				@word.Selection.Font.Name = police
				@word.Selection.Font.Size = t[1]
				@word.Selection.Font.Color = valeur
				@word.Selection.ParagraphFormat.Alignment = position
				@word.Selection.TypeText(s)
				
			end
		end
	end
	
	
	#démarre une nouvelle page
	def nouvellePage() 
		@word.Selection.InsertNewPage
	end
	
	#ajouter un image
	# param image : String
	# param position : String
	def ajouterImage(image,position)
		position = @justification[position]
		
		@word.Selection.ParagraphFormat.Alignment = position
		
		@word.Selection.InlineShapes.AddPicture(
			fileName = image,
			linkToFile = false,
			saveWithDocument = true
		)
	end
	
	#sauter une ligne
	def sauterLigne()
		@word.Selection.TypeParagraph()
	end
	
end




