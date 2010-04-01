# -*- coding: utf-8 -*-


##############################################################################
# Projet L3 Groupe 2 : classe FenetreExportPDF
#
# La fenêtre pour exporter un document au format PDF
#
# dernière modification :	11/04/07, Romain
# 
# 
##############################################################################

require "gtk2"
include Gtk



class FenetreExportPDF
	
	def initialize(document)
		Gtk.init
    
		@document = document
		fonts = [
			"Courier","Courier-Bold","Courier-Oblique","Courier-BoldOblique",
			"Helvetica","Helvetica-Bold","Helvetica-Oblique","Helvetica-BoldOblique",
			"Times-Roman","Times-Bold","Times-Italic","Times-BoldItalic"
		]
		tailles = [8,9,10,11,12,13,14,16,18,20,22,24,26,28,32,34,40,48]
		
		
		
		@maFenetre = Window.new()
		@maFenetre.modal = true
		
		@maFenetre.set_window_position(Window::POS_CENTER_ALWAYS)
		@maFenetre.set_title("Export PDF").set_default_size(800, 400)
		@maFenetre.signal_connect("destroy"){ Gtk.main_quit }
		
		maVBoxPrincipale = VBox.new()
		
		###################DEBUT ONGLET 1
		maFrame1 = VBox.new()
		
		maHBox1 = HBox.new()
		
		@btnPoliceTitre = ComboBox.new()
		fonts.each do |t| @btnPoliceTitre.append_text(t.to_s) end
		@btnPoliceTitre.active = fonts.index("Times-Bold")
		
		maHBox1.pack_start(Label.new("Police du titre"), false, false, 5)
		maHBox1.pack_start(@btnPoliceTitre, false, false, 5)
		
		
		maHBox2 = HBox.new()
		
		@btnTailleTitre = ComboBox.new()
		tailles.each do |t| @btnTailleTitre.append_text(t.to_s) end
		@btnTailleTitre.active = tailles.index(TAILLE_TITRE_DOCUMENT).to_i
		
		maHBox2.pack_start(Label.new("Taille du titre"), false, false, 5)
		maHBox2.pack_start(@btnTailleTitre, false, false, 5)
		
		
		maHBox3 = HBox.new()
		
		@btnCouleurTitre = ColorButton.new()
		
		maHBox3.pack_start(Label.new("Couleur du titre"), false, false, 5)
		maHBox3.pack_start(@btnCouleurTitre, false, false, 5)
		
		maHBox4 = HBox.new()
		
		@btnGaucheTitre = RadioButton.new("A gauche", false).set_image(Gtk::Image.new(Stock::JUSTIFY_LEFT,IconSize::LARGE_TOOLBAR))
		@btnCentrerTitre = RadioButton.new(@btnGaucheTitre , "Centrer", false).set_image(Gtk::Image.new(Stock::JUSTIFY_CENTER,IconSize::LARGE_TOOLBAR))
		@btnDroitTitre = RadioButton.new(@btnGaucheTitre , "A droite", false).set_image(Gtk::Image.new(Stock::JUSTIFY_RIGHT,IconSize::LARGE_TOOLBAR))
		@btnJustifierTitre = RadioButton.new(@btnGaucheTitre , "Justifier", false).set_image(Gtk::Image.new(Stock::JUSTIFY_FILL,IconSize::LARGE_TOOLBAR))
		
		@btnCentrerTitre.active = true
		
		
		maHBox4.pack_start(Label.new("Position du texte"), false, false, 5)
		maHBox4.pack_start(@btnGaucheTitre, false, false, 5)
		maHBox4.pack_start(@btnCentrerTitre, false, false, 5)
		maHBox4.pack_start(@btnDroitTitre, false, false, 5)
		maHBox4.pack_start(@btnJustifierTitre, false, false, 5)
		
		
		
		maFrame1.pack_start(maHBox1, false, false, 5)
		maFrame1.pack_start(maHBox2, false, false, 5)
		maFrame1.pack_start(maHBox3, false, false, 5)
		maFrame1.pack_start(maHBox4, false, false, 5)
		
		####################FIN ONGLET 1
		###################DEBUT ONGLET 2
		maFrame2 = VBox.new()
		
		maHBox1 = HBox.new()
		
		@btnPoliceDescriptif = ComboBox.new()
		fonts.each do |t| @btnPoliceDescriptif.append_text(t.to_s) end
		@btnPoliceDescriptif.active = fonts.index("Times-Roman")
		
		maHBox1.pack_start(Label.new("Police du descriptif"), false, false, 5)
		maHBox1.pack_start(@btnPoliceDescriptif, false, false, 5)
		
		
		maHBox2 = HBox.new()
		
		@btnTailleDescriptif = ComboBox.new()
		tailles.each do |t| @btnTailleDescriptif.append_text(t.to_s) end
		@btnTailleDescriptif.active = tailles.index(TAILLE_DESCRIPTIF).to_i
		
		maHBox2.pack_start(Label.new("Taille du titre"), false, false, 5)
		maHBox2.pack_start(@btnTailleDescriptif, false, false, 5)
		
		maHBox3 = HBox.new()
		
		@btnCouleurDescriptif = ColorButton.new()
		
		maHBox3.pack_start(Label.new("Couleur du descriptif"), false, false, 5)
		maHBox3.pack_start(@btnCouleurDescriptif, false, false, 5)
		
		
		maHBox4 = HBox.new()
		
		@btnGaucheDescriptif = RadioButton.new("A gauche", false).set_image(Gtk::Image.new(Stock::JUSTIFY_LEFT,IconSize::LARGE_TOOLBAR))
		@btnCentrerDescriptif = RadioButton.new(@btnGaucheDescriptif , "Centrer", false).set_image(Gtk::Image.new(Stock::JUSTIFY_CENTER,IconSize::LARGE_TOOLBAR))
		@btnDroitDescriptif = RadioButton.new(@btnGaucheDescriptif , "A droite", false).set_image(Gtk::Image.new(Stock::JUSTIFY_RIGHT,IconSize::LARGE_TOOLBAR))
		@btnJustifierDescriptif = RadioButton.new(@btnGaucheDescriptif , "Justifier", false).set_image(Gtk::Image.new(Stock::JUSTIFY_FILL,IconSize::LARGE_TOOLBAR))

		@btnCentrerDescriptif.active = true
		
		maHBox4.pack_start(Label.new("Position du texte"), false, false, 5)
		maHBox4.pack_start(@btnGaucheDescriptif, false, false, 5)
		maHBox4.pack_start(@btnCentrerDescriptif, false, false, 5)
		maHBox4.pack_start(@btnDroitDescriptif, false, false, 5)
		maHBox4.pack_start(@btnJustifierDescriptif, false, false, 5)
		
		
		
		maFrame2.pack_start(maHBox1, false, false, 5)
		maFrame2.pack_start(maHBox2, false, false, 5)
		maFrame2.pack_start(maHBox3, false, false, 5)
		maFrame2.pack_start(maHBox4, false, false, 5)
		
		####################FIN ONGLET 2
		###################DEBUT ONGLET 3
		maFrame3 = VBox.new()
		
		frameTitrePartie = Frame.new("Titre de partie")
		
		maVBox1 = VBox.new()
		
		maHBox1 = HBox.new()
		
		@btnPoliceTitrePartie = ComboBox.new()
		fonts.each do |t| @btnPoliceTitrePartie.append_text(t.to_s) end
		@btnPoliceTitrePartie.active = fonts.index("Times-Bold")
		
		maHBox1.pack_start(Label.new("Police du titre d'une partie"), false, false, 5)
		maHBox1.pack_start(@btnPoliceTitrePartie, false, false, 5)
		
		
		maHBox2 = HBox.new()
		
		@btnTailleTitrePartie = ComboBox.new()
		tailles.each do |t| @btnTailleTitrePartie.append_text(t.to_s) end
		@btnTailleTitrePartie.active = tailles.index(TAILLE_TITRE_PARTIE).to_i

		
		
		maHBox2.pack_start(Label.new("Taille du titre d'une partie"), false, false, 5)
		maHBox2.pack_start(@btnTailleTitrePartie, false, false, 5)
		
		maHBox3 = HBox.new()
		
		@btnCouleurTitrePartie = ColorButton.new()
		
		maHBox3.pack_start(Label.new("Couleur"), false, false, 5)
		maHBox3.pack_start(@btnCouleurTitrePartie, false, false, 5)
		
		
		
		maHBox4 = HBox.new()
		
		@btnGaucheTitrePartie = RadioButton.new("A gauche", false).set_image(Gtk::Image.new(Stock::JUSTIFY_LEFT,IconSize::LARGE_TOOLBAR))
		@btnCentrerTitrePartie = RadioButton.new(@btnGaucheTitrePartie , "Centrer", false).set_image(Gtk::Image.new(Stock::JUSTIFY_CENTER,IconSize::LARGE_TOOLBAR))
		@btnDroitTitrePartie = RadioButton.new(@btnGaucheTitrePartie , "A droite", false).set_image(Gtk::Image.new(Stock::JUSTIFY_RIGHT,IconSize::LARGE_TOOLBAR))
		@btnJustifierTitrePartie = RadioButton.new(@btnGaucheTitrePartie , "Justifier", false).set_image(Gtk::Image.new(Stock::JUSTIFY_FILL,IconSize::LARGE_TOOLBAR))
		
		@btnCentrerTitrePartie.active = true
		
		maHBox4.pack_start(Label.new("Position du texte"), false, false, 5)
		maHBox4.pack_start(@btnGaucheTitrePartie, false, false, 5)
		maHBox4.pack_start(@btnCentrerTitrePartie, false, false, 5)
		maHBox4.pack_start(@btnDroitTitrePartie, false, false, 5)
		maHBox4.pack_start(@btnJustifierTitrePartie, false, false, 5)
		
		maVBox1.pack_start(maHBox1, false, false, 5)
		maVBox1.pack_start(maHBox2, false, false, 5)
		maVBox1.pack_start(maHBox3, false, false, 5)
		maVBox1.pack_start(maHBox4, false, false, 5)
		
		frameTitrePartie.add(maVBox1)
		
		
		frameParagraphe = Frame.new("Paragraphe")
		
		maVBox2 = VBox.new()
		
		maHBox1 = HBox.new()
		
		@btnPoliceParagraphe = ComboBox.new()
		fonts.each do |t| @btnPoliceParagraphe.append_text(t.to_s) end
		@btnPoliceParagraphe.active = fonts.index("Times-Roman")
		
		maHBox1.pack_start(Label.new("Police d'un paragraphe"), false, false, 5)
		maHBox1.pack_start(@btnPoliceParagraphe, false, false, 5)
		
		
		maHBox2 = HBox.new()
		
		@btnTailleParagraphe = ComboBox.new()
		tailles.each do |t| @btnTailleParagraphe.append_text(t.to_s) end
		@btnTailleParagraphe.active = tailles.index(TAILLE_PARAGRAPHE).to_i
		
		
		maHBox2.pack_start(Label.new("Taille du paragraphe"), false, false, 5)
		maHBox2.pack_start(@btnTailleParagraphe, false, false, 5)
		
		maHBox3 = HBox.new()
		
		@btnCouleurParagraphe = ColorButton.new()
		
		maHBox3.pack_start(Label.new("Couleur"), false, false, 5)
		maHBox3.pack_start(@btnCouleurParagraphe, false, false, 5)
		
		
		
		maHBox4 = HBox.new()
		
		@btnGaucheParagraphe = RadioButton.new("A gauche", false).set_image(Gtk::Image.new(Stock::JUSTIFY_LEFT,IconSize::LARGE_TOOLBAR))
		@btnCentrerParagraphe = RadioButton.new(@btnGaucheParagraphe , "Centrer", false).set_image(Gtk::Image.new(Stock::JUSTIFY_CENTER,IconSize::LARGE_TOOLBAR))
		@btnDroitParagraphe = RadioButton.new(@btnGaucheParagraphe , "A droite", false).set_image(Gtk::Image.new(Stock::JUSTIFY_RIGHT,IconSize::LARGE_TOOLBAR))
		@btnJustifierParagraphe = RadioButton.new(@btnGaucheParagraphe , "Justifier", false).set_image(Gtk::Image.new(Stock::JUSTIFY_FILL,IconSize::LARGE_TOOLBAR))
		
		
		maHBox4.pack_start(Label.new("Position du texte"), false, false, 5)
		maHBox4.pack_start(@btnGaucheParagraphe, false, false, 5)
		maHBox4.pack_start(@btnCentrerParagraphe, false, false, 5)
		maHBox4.pack_start(@btnDroitParagraphe, false, false, 5)
		maHBox4.pack_start(@btnJustifierParagraphe, false, false, 5)
		
		maVBox2.pack_start(maHBox1, false, false, 5)
		maVBox2.pack_start(maHBox2, false, false, 5)
		maVBox2.pack_start(maHBox3, false, false, 5)
		maVBox2.pack_start(maHBox4, false, false, 5)
		
		frameParagraphe.add(maVBox2)
		
		frameImage = Frame.new("Image")
		
		maVBox3 = VBox.new()
		
		
		maHBox2 = HBox.new()
		
		adjustment = Gtk::Adjustment.new(100.0,          # initial
                                         25.0,          # min
                                         201.0,  		# max
                                         1.0,          # step
                                         1.0,          # page
                                         1.0)          # page_size
        @btnTailleImage = HScale.new(adjustment)
        @btnTailleImage.set_draw_value(true).set_digits(1).set_size_request(150, 50).set_update_policy(UPDATE_CONTINUOUS)
		
		maHBox2.pack_start(Label.new("Redimmensionnement"), false, false, 5)
		maHBox2.pack_start(@btnTailleImage, false, false, 5)
		
		maVBox3.pack_start(maHBox2, false, false, 5)
		
		maHBox3 = HBox.new()
		
		@btnGaucheImage = RadioButton.new("A gauche", false).set_image(Gtk::Image.new(Stock::JUSTIFY_LEFT,IconSize::LARGE_TOOLBAR))
		@btnCentrerImage = RadioButton.new(@btnGaucheImage , "Centrer", false).set_image(Gtk::Image.new(Stock::JUSTIFY_CENTER,IconSize::LARGE_TOOLBAR))
		@btnDroitImage = RadioButton.new(@btnGaucheImage , "A droite", false).set_image(Gtk::Image.new(Stock::JUSTIFY_RIGHT,IconSize::LARGE_TOOLBAR))
		
		
		maHBox3.pack_start(Label.new("Position du texte"), false, false, 5)
		maHBox3.pack_start(@btnGaucheImage, false, false, 5)
		maHBox3.pack_start(@btnCentrerImage, false, false, 5)
		maHBox3.pack_start(@btnDroitImage, false, false, 5)
		
		@btnCentrerImage.active = true
		
		maVBox3.pack_start(maHBox3, false, false, 5)
		
		frameImage.add(maVBox3)
		
		maFrame3.pack_start(frameTitrePartie, false, false, 5)
		maFrame3.pack_start(frameParagraphe, false, false, 5)
		maFrame3.pack_start(frameImage, false, false, 5)
		
		
		####################FIN ONGLET 3
		
		
		mesOnglets = Notebook.new().set_scrollable(true)
		frameOnglet = {
			"Titre" => maFrame1,
			"Descriptif" => maFrame2,
			"Parties" => maFrame3
		}
		titreOnglet = [
			"Titre",
			"Descriptif",
			"Parties"
		]
		
		titreOnglet.each do |titre|
			frame = frameOnglet[titre]
			
			ongBox = HBox.new()
			ongBox.pack_start(Label.new(titre),false,false,0).show_all()
			
			mesOnglets.append_page_menu(frame,ongBox,Label.new(titre))
		end
		
		
		maHBoxNomFichier = HBox.new()
		
		@entryNomFichier = Entry.new()
		
		maHBoxNomFichier.pack_start(Label.new("Nom du fichier PDF"), false, false, 5)
		maHBoxNomFichier.pack_start(@entryNomFichier, false, false, 5)
		
		
		maHBoxBtns = HBox.new()
		
		btnFermer = Button.new("Fermer").set_image(Gtk::Image.new(Stock::QUIT,IconSize::LARGE_TOOLBAR))
		btnExporter = Button.new("Exporter").set_image(Gtk::Image.new(Stock::CONVERT,IconSize::LARGE_TOOLBAR))
		
		btnFermer.signal_connect("clicked") do 
			@maFenetre.destroy()
		end
		
		btnExporter.signal_connect("clicked") do 
			self.exportation()
		end
		
		maHBoxBtns.pack_start(btnFermer, false, false, 5)
		maHBoxBtns.pack_end(btnExporter, false, false, 5)
		
		maVBoxPrincipale.pack_start(mesOnglets, false, false, 0)
		maVBoxPrincipale.pack_start(maHBoxNomFichier, false, false, 0)
		maVBoxPrincipale.pack_start(maHBoxBtns, false, false, 0)
		
		
		@maFenetre.add(maVBoxPrincipale)
		@maFenetre.show_all()
    
    Gtk.main
	end
	
	def exportation()
		
		nomFichier = @entryNomFichier.text.strip
		
		if nomFichier == ""
			quickMessage("Il faut rentrer un nom de fichier !")
		else
			
			fontTitre = @btnPoliceTitre.active_text
			tailleTitre = @btnTailleTitre.active_text.to_i
			couleurTitre = Color::RGB.new(
						@btnCouleurTitre.color.red.to_f / 256.0,
						@btnCouleurTitre.color.green.to_f / 256.0,
						@btnCouleurTitre.color.blue.to_f / 256.0
			)
			positionTitre = ""
			@btnGaucheTitre.group.each do |b| positionTitre = b.label if b.active?() end
			
			
			fontDescriptif = @btnPoliceDescriptif.active_text
			tailleDescriptif = @btnTailleDescriptif.active_text.to_i
			couleurDescriptif= Color::RGB.new(
						@btnCouleurDescriptif.color.red.to_f / 256.0,
						@btnCouleurDescriptif.color.green.to_f / 256.0,
						@btnCouleurDescriptif.color.blue.to_f / 256.0
			)
			positionDescriptif = ""
			@btnGaucheDescriptif.group.each do |b| positionDescriptif = b.label if b.active?() end
			
			fontTitrePartie = @btnPoliceTitrePartie.active_text
			tailleTitrePartie = @btnTailleTitrePartie.active_text.to_i
			couleurTitrePartie = Color::RGB.new(
						@btnCouleurTitrePartie.color.red.to_f / 256.0,
						@btnCouleurTitrePartie.color.green.to_f / 256.0,
						@btnCouleurTitrePartie.color.blue.to_f / 256.0
			)
			positionTitrePartie = ""
			@btnGaucheTitrePartie.group.each do |b| positionTitrePartie = b.label if b.active?() end
			
			fontParagraphe = @btnPoliceParagraphe.active_text
			tailleParagraphe = @btnTailleParagraphe.active_text.to_i
			couleurParagraphe = Color::RGB.new(
						@btnCouleurParagraphe.color.red.to_f / 256.0,
						@btnCouleurParagraphe.color.green.to_f / 256.0,
						@btnCouleurParagraphe.color.blue.to_f / 256.0
			)
			positionParagraphe = ""
			@btnGaucheParagraphe.group.each do |b| positionParagraphe = b.label if b.active?() end
			
			tailleImage = (@btnTailleImage.value.to_f) / 100
			positionImage = ""
			@btnGaucheImage.group.each do |b| positionImage = b.label if b.active?() end
			
			#création du Pdf Writer
			pdf = PDFWriter.new()
			
			#On place le titre au centre de la page
			pdf.bougerVerticalement(150)
			
			#le titre du document
			pdf.ajouterTexte(
					fontTitre,
					@document.titre,
					tailleTitre,
					couleurTitre,
					positionTitre
			)
			
			#on place le descriptif en dessous
			pdf.bougerVerticalement(50)
			
			#le descriptif du document
			pdf.ajouterTexte(
					fontDescriptif,
					@document.descriptif,
					tailleDescriptif,
					couleurDescriptif,
					positionDescriptif
			)
			
			pdf.nouvellePage()
			
			#pour chaque partie du document
			@document.eachPartie do |partie|
				
				#le titre de la partie
				pdf.ajouterTexte(
					fontTitrePartie,
					partie.titre,
					tailleTitrePartie,
					couleurTitrePartie,
					positionTitrePartie
				)
				
				pdf.bougerVerticalement(10)
				
				#si c'est une image
				if partie.instance_of?(Image)
					#on vérifie l'extension (les gifs font planter)
					if /(.png|.bmp|.jpg)$/.match(partie.contenu)
						pdf.ajouterImage(
							partie.contenu,
							tailleImage,
							positionImage
						)
					end
					
				#ou un paragaraphe
				elsif partie.instance_of?(Paragraphe)
					pdf.ajouterTexte(
						fontParagraphe,
						partie.contenu,
						tailleParagraphe,
						couleurParagraphe,
						positionParagraphe
					)
				end
				pdf.bougerVerticalement(30)
				
			end
			
			#on crée une nouvelle page
			pdf.nouvellePage()
			
			h = 18
			y0 = pdf.getY() + h
			
			if @document.auteur == nil
				auteur = "Non défini"
			else
				auteur = @document.auteur.nom
			end
			
			couleurNoire = Color::RGB.new(0,0,0)
			
			#affichage de l'auteur
			pdf.ajouterTexte(
				"Courier-Oblique",
				"Auteur :",
				16,
				couleurNoire,
				"Centrer"
			)
			
			pdf.bougerVerticalement(10)
			
			pdf.ajouterTexte(
				"Times-Bold",
				auteur,
				18,
				couleurNoire,
				"Centrer"
			)
			
			#on laisse un peu d'espace
			pdf.bougerVerticalement(36)
			
			
			#affichage des contributeurs
			pdf.ajouterTexte(
				"Courier-Oblique",
				"Contributeurs :",
				16,
				couleurNoire,
				"Centrer"
			)
			
			pdf.bougerVerticalement(10)
			
			@document.listeContributeurs.compact().each do |c|
				pdf.ajouterTexte(
					"Times-Bold",
					c.nom,
					18,
					couleurNoire,
					"Centrer"
				)
			end
			pdf.dessinerCadre(25,y0,-50,h,10)
			
			pdf.sauverSous(nomFichier)
			
			quickMessage("Votre document a été exporté dans le fichier \"#{nomFichier}.pdf\"")
			
		end
	end
end

