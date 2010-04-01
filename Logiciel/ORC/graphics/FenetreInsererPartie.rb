require 'gtk2'


class FenetreInsererPartie
	
	@partieRetournee
		
	attr_reader :partieRetournee
	
	def initialize()
		
		Gtk.init
		
		@fenetre = Gtk::Window.new()
		@fenetre.title = "Inserer une partie"
		@fenetre.window_position = Gtk::Window::POS_CENTER
		@fenetre.modal = true
		@fenetre.signal_connect('destroy') do
      Gtk.main_quit()
    end
		
		@boiteFenetre = Gtk::VBox.new()
		
		@boiteTitre = Gtk::HBox.new(false)
		@boiteType = Gtk::HBox.new(false)
		@boiteContenu = Gtk::HBox.new()
		@boiteBoutons = Gtk::HBox.new(true)
		
		
		@labelTitre = Gtk::Label.new("Titre : ")
		@entreeTitre = Gtk::Entry.new()
		
		@boiteTitre.pack_start(@labelTitre,false,false,0)
		@boiteTitre.pack_start(@entreeTitre,true,true,0)
		
		@labelType = Gtk::Label.new("Type : ")
		@boiteType.pack_start(@labelType,false,false,0)
		@radioTexte = Gtk::RadioButton.new("Paragraphe")
		@boiteType.pack_start(@radioTexte,true,false,0)
		@radioImage = Gtk::RadioButton.new(@radioTexte, "Image")
		@boiteType.pack_start(@radioImage,true,false,0)
		
		
		#creation contenu de la fenetre
		
		@apercu = Gtk::Image.new()
		@boutonParcourir = Gtk::Button.new(Gtk::Stock::FIND)
		
		@boiteContenu.pack_start(@apercu,true,true,0)
		@boiteContenu.pack_start(@boutonParcourir,false,false,0)
		
		@radioTexte.signal_connect('clicked') do
			@boiteContenu.hide()
		end
		
		@radioImage.signal_connect('clicked') do
			@boiteContenu.show()
		end
		
		@boutonParcourir.signal_connect('clicked') do
			@nomFich = selectionnerFichier()
			@apercu.file = @nomFich
		end
			
		@boutonAnnuler = Gtk::Button.new(Gtk::Stock::CANCEL)
		@boutonValider = Gtk::Button.new(Gtk::Stock::OK)
		
		@boutonValider.signal_connect('clicked') do
			if(@radioTexte.active?())
				@partieRetournee = Paragraphe.creer(GestionnairePartie.donnerNumeroPartieLibre(), @entreeTitre.text, "")
			else(@radioImage.active?())
				@partieRetournee = Image.creer(GestionnairePartie.donnerNumeroPartieLibre(), @entreeTitre.text, @nomFich)
			end
			@fenetre.destroy()
		end
		
    @boutonAnnuler.signal_connect('clicked') do
      @fenetre.destroy()
    end
    
		@boiteBoutons.pack_start(@boutonAnnuler,true,true,0)
		@boiteBoutons.pack_start(@boutonValider,true,true,0)
		
		
		@boiteFenetre.pack_start(@boiteTitre,false,false,0)
		@boiteFenetre.pack_start(@boiteType,false,0)
		@boiteFenetre.pack_start(@boiteContenu,true,true,0)
		@boiteFenetre.pack_start(@boiteBoutons,false,false,0)
		
		@fenetre.add(@boiteFenetre)
		@fenetre.show_all()
		
		@boiteContenu.hide()
		
		Gtk.main
	end
	
	def selectionnerFichier()
		@fenetreSelectionFichier = Gtk::FileChooserDialog.new("Open File",
                                     nil,
                                     Gtk::FileChooser::ACTION_OPEN,
                                     nil,
                                     [Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL],
                                     [Gtk::Stock::OPEN, Gtk::Dialog::RESPONSE_ACCEPT])
		ret = @fenetreSelectionFichier.run
		if ret == Gtk::Dialog::RESPONSE_ACCEPT
			if File.directory?(@fenetreSelectionFichier.filename)
				dialog = Gtk::MessageDialog.new(@fenetre, Gtk::Dialog::MODAL, 
				Gtk::MessageDialog::ERROR, 
				Gtk::MessageDialog::BUTTONS_CLOSE, 
				"Directory was selected. Select a text file.")
				dialog.run
				dialog.destroy
				@fenetreSelectionFichier.destroy
			else
				@nomFichier = @fenetreSelectionFichier.filename
				@fenetreSelectionFichier.destroy
			end
		else
			@fenetreSelectionFichier.destroy
		end
		
		return @nomFichier
	end
end
