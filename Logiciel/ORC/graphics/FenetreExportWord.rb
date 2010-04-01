# -*- coding: utf-8 -*-


##############################################################################
# Projet L3 Groupe 2 : classe FenetreExportWord
#
# La fenêtre pour exporter un document dans Word
#
# dernière modification :	11/04/07, Romain
# 
# 
##############################################################################

require "gtk2"
include Gtk


class FenetreExportWord
	
	def initialize(document)
		Gtk.init
		
		@document = document
		
		@maFenetre = Window.new()
		
		@maFenetre.set_window_position(Window::POS_CENTER_ALWAYS)
		@maFenetre.set_title("Export vers Word").set_default_size(800, 400)
		@maFenetre.signal_connect("destroy"){ Gtk.main_quit }
		
		maVBoxPrincipale = VBox.new()
		
		###################DEBUT ONGLET 1
		maFrame1 = VBox.new()
		
		maHBox1 = HBox.new()
		
		@btnPoliceTitre = FontButton.new().set_show_style(true).set_font_name("Arial Bold " + TAILLE_TITRE_DOCUMENT.to_s())
		
		
		maHBox1.pack_start(Label.new("Police du titre"), false, false, 5)
		maHBox1.pack_start(@btnPoliceTitre, false, false, 5)
		
		
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
		maFrame1.pack_start(maHBox3, false, false, 5)
		maFrame1.pack_start(maHBox4, false, false, 5)
		
		####################FIN ONGLET 1
		###################DEBUT ONGLET 2
		
		maFrame2 = VBox.new()
		
		maHBox1 = HBox.new()
		
		@btnPoliceDescriptif = FontButton.new().set_show_style(true).set_font_name("Times New Roman " + TAILLE_DESCRIPTIF.to_s())
		
		maHBox1.pack_start(Label.new("Police du descriptif"), false, false, 5)
		maHBox1.pack_start(@btnPoliceDescriptif, false, false, 5)


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
		maFrame2.pack_start(maHBox3, false, false, 5)
		maFrame2.pack_start(maHBox4, false, false, 5)
		
		####################FIN ONGLET 2
		###################DEBUT ONGLET 3
		
		maFrame3 = VBox.new()
		
		frameTitrePartie = Frame.new("Titre de partie")
		
		maVBox1 = VBox.new()
		
		maHBox1 = HBox.new()
		
		@btnPoliceTitrePartie = FontButton.new().set_show_style(true).set_font_name("Arial Bold " + TAILLE_TITRE_PARTIE.to_s())
		
		maHBox1.pack_start(Label.new("Police"), false, false, 5)
		maHBox1.pack_start(@btnPoliceTitrePartie, false, false, 5)
		
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
		maVBox1.pack_start(maHBox3, false, false, 5)
		maVBox1.pack_start(maHBox4, false, false, 5)
		
		frameTitrePartie.add(maVBox1)
		
		
		frameParagraphe = Frame.new("Paragraphe")
		
		maVBox2 = VBox.new()
		
		maHBox1 = HBox.new()
		
		@btnPoliceParagraphe = FontButton.new().set_show_style(true).set_font_name("Times New Roman " + TAILLE_PARAGRAPHE.to_s())
		
		maHBox1.pack_start(Label.new("Police"), false, false, 5)
		maHBox1.pack_start(@btnPoliceParagraphe, false, false, 5)
		
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
		maVBox2.pack_start(maHBox3, false, false, 5)
		maVBox2.pack_start(maHBox4, false, false, 5)
		
		frameParagraphe.add(maVBox2)
		
		frameImage = Frame.new("Image")
		
		maVBox3 = VBox.new()
		
		maHBox3 = HBox.new()
		
		@btnGaucheImage = RadioButton.new("A gauche", false).set_image(Gtk::Image.new(Stock::JUSTIFY_LEFT,IconSize::LARGE_TOOLBAR))
		@btnCentrerImage = RadioButton.new(@btnGaucheImage , "Centrer", false).set_image(Gtk::Image.new(Stock::JUSTIFY_CENTER,IconSize::LARGE_TOOLBAR))
		@btnDroitImage = RadioButton.new(@btnGaucheImage , "A droite", false).set_image(Gtk::Image.new(Stock::JUSTIFY_RIGHT,IconSize::LARGE_TOOLBAR))
		
		
		maHBox3.pack_start(Label.new("Position de l'image"), false, false, 5)
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
		maVBoxPrincipale.pack_start(maHBoxBtns, false, false, 0)
		
		
		@maFenetre.add(maVBoxPrincipale)
		@maFenetre.show_all()
    
    Gtk.main
	end
	
	def exportation()
	
		fontTitre = @btnPoliceTitre.font_name
		couleurTitre = @btnCouleurTitre.color
		positionTitre = ""
		@btnGaucheTitre.group.each do |b| positionTitre = b.label if b.active?() end
		
		fontDescriptif = @btnPoliceDescriptif.font_name
		couleurDescriptif = @btnCouleurDescriptif.color
		positionDescriptif = ""
		@btnGaucheDescriptif.group.each do |b| positionDescriptif = b.label if b.active?() end
		
		fontTitrePartie = @btnPoliceTitrePartie.font_name
		couleurTitrePartie = @btnCouleurTitrePartie.color
		positionTitrePartie = ""
		@btnGaucheTitrePartie.group.each do |b| positionTitrePartie = b.label if b.active?() end

		fontParagraphe = @btnPoliceParagraphe.font_name
		couleurParagraphe = @btnCouleurParagraphe.color
		positionParagraphe = ""
		@btnGaucheParagraphe.group.each do |b| positionParagraphe = b.label if b.active?() end
		
		positionImage = ""
		@btnGaucheImage.group.each do |b| positionImage = b.label if b.active?() end
		
		######
		#on crée l'objet Word
		word = Doc2Word.new()
		
		#on saute 10 lignes
		0.upto(10) do word.sauterLigne() end
		
		#le titre du document
		word.ajouterTexte(
				fontTitre,
				@document.titre,
				couleurTitre,
				positionTitre
		)
		
		#on saute 2 lignes
		0.upto(1) do word.sauterLigne() end
			
		#le descriptif du document
		word.ajouterTexte(
				fontDescriptif,
				@document.descriptif,
				couleurDescriptif,
				positionDescriptif
		)
		
		#on démarre une nouvelle page
		word.nouvellePage()
		
		#pour chaque partie du document
		@document.eachPartie do |partie|
			
			#le titre de la partie
			word.ajouterTexte(
				fontTitrePartie,
				partie.titre,
				couleurTitrePartie,
				positionTitrePartie
			)
			
			word.sauterLigne()
			
			if partie.instance_of?(Image)
				word.ajouterImage(
					partie.contenu,
					positionImage
				)
			
			elsif partie.instance_of?(Paragraphe)
				word.ajouterTexte(
					fontParagraphe,
					partie.contenu,
					couleurParagraphe,
					positionParagraphe
				)
			end
			
			2.times do word.sauterLigne() end
			
		end
	end
end
