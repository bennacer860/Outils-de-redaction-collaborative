# -*- coding: utf-8 -*-



##############################################################################
# Projet L3 Groupe 2 : classe PDFWriter
# Pour exporter un document au format PDF
#
# dernière modification :	11/04/07, Romain
# 
# 
##############################################################################


#classe qui permet d'insérer le style "texte barré"
class TagStrike
	DEFAULT_STYLE = {
		:factor =>  0.05
	}
	class << self
		attr_accessor :style
		def [](pdf, info)
			@style ||= DEFAULT_STYLE.dup
			case info[:status]
				when :start, :start_line
					@links ||= {}
					@links[info[:cbid]] = {
						:x => info[:x],
						:y => info[:y],
						:angle => info[:angle],
						:descender => info[:descender],
						:height => info[:height],
						:uri => nil
					}
					pdf.save_state
					pdf.stroke_style! PDF::Writer::StrokeStyle.new(info[:height] * @style[:factor])
				when :end, :end_line
					start = @links[info[:cbid]]
					drop_y= (start[:height] * 2 ) * @style[:factor] * 1.5
					pdf.move_to(start[:x] , start[:y] + drop_y)
					pdf.line_to(info[:x] , info[:y] + drop_y).stroke
					pdf.restore_state
			end
		end
	end
end




#classe qui gère l'export d'un document au format PDF
class PDFWriter
	
	@parseur 				#ParseurHtml2PDFWriter : Conversion des balises HTML
	@pdf 					#PDF::Writer : gestion du PDF
	@justification 			#Hash : gestion de la justification du texte
	
	def initialize()
		PDF::Writer::TAGS[:pair]["s"] = TagStrike			#on ajoute le style "texte barré"
		@parseur = ParseurHtml2PDFWriter.new()
		@pdf = PDF::Writer.new()
		@justification = {
			"A gauche" => :left,
			"Centrer" => :center,
			"A droite" => :right,
			"Justifier" => :full
		}
	end
	
	#ajout de texte
	# param font : String
	# param texte : String
	# param taille : FixNum
	# param texte : Color::RGB
	# param texte : String
	def ajouterTexte(font,texte,taille,couleur,position)
		
		begin
			@pdf.select_font(font)
		rescue
			@pdf.select_font("Times-Roman")
		end
		tailleDefaut = taille
		
		texte = GLib.convert(texte, "ISO-8859-15", "UTF-8")
		texte = @parseur.html2PDFWriter(texte)
		
		r = %r{(<big>.*</big>)|(<small>.*</small>)|(<span size=.*>.*</span>)}
		texte.split(r).each do |c|
			if %r{<big>(.*)</big>}.match(c)
				texte = $1
				taille += 2
			elsif %r{<small>(.*)</small>}.match(c)
				texte = $1
				taille -= 2
			elsif %r{<span size=\"(x{1,2})-large\">(.*)</span>}.match(c)
				case $1
					when "x"
						taille = 20
					when "xx"
						taille = 26
				end
				texte = $2
			else
				taille = tailleDefaut
				texte = c
			end
			
			@pdf.fill_color(couleur)
			@pdf.text(
				texte, 
				:font_size => taille, 
				:justification => @justification[position]
			)
		end
	end
	
	#Retourne la position du pointeur
	def getY()
		return @pdf.y
	end
	
	#démarre une nouvelle page
	def nouvellePage() 
		@pdf.start_new_page()
	end
	
	#ajouter un image
	# param image : String
	# param taille : Fixnum
	# param position : String
	def ajouterImage(image,taille,position)
		@pdf.image(
			image,
			:resize => taille,
			:justification => @justification[position]
		)
	end
	
	#bouger le pointeur verticalement
	#param val Fixnum
	def bougerVerticalement(val)
		@pdf.move_pointer(val)
	end
	
	#dessine un cadre
	#param x,y,w,h,r Fixnum
	def dessinerCadre(x,y,w,h,r)
		@pdf.rounded_rectangle(
			@pdf.left_margin + x,
			y,
			@pdf.margin_width + w,
			y - @pdf.y + h,
			r
		).stroke
	end
	
	#sauvegarder le fichier
	#param nom String
	def sauverSous(nom)
		@pdf.save_as(nom + ".pdf")
	end
	
end




