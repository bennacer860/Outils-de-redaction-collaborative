class FenetreEditerImage
  
  def initialize(partie)
    Gtk.init
    
    @nomFichier = partie.contenu
    
    @fenetre = Gtk::Window.new()
    @fenetre.title = "Editer la partie"
    @fenetre.set_default_size(350,250)
    @fenetre.window_position = Gtk::Window::POS_CENTER
    @fenetre.signal_connect('destroy') do
      Gtk.main_quit()
    end
    
    @boiteFenetre = Gtk::VBox.new()
    
    # Titre
    @boiteTitre = Gtk::HBox.new()
    
    @labelTitre = Gtk::Label.new("Titre : ")
    @saisieTitre = Gtk::Entry.new()
    @saisieTitre.text = partie.titre
    
    @boiteTitre.pack_start(@labelTitre, false, false, 0)
    @boiteTitre.pack_start(@saisieTitre, true, true, 0)
    
    # Label Contenu
    @labelContenu = Gtk::Label.new("Contenu :")
    
    # Boite pour l'apercu
    
    @boiteApercu = HBox.new()
    
    @apercu = Gtk::Image.new()
    @boutonApercu = Gtk::Button.new("Parcourir")
    
    @boiteApercu.pack_start(@apercu, true, true, 0)
    @boiteApercu.pack_start(@boutonApercu, false, false, 0)
    
    # Boutons
    @boiteBoutons = Gtk::HBox.new()

    @boutonAnnuler = Gtk::Button.new(Gtk::Stock::CANCEL)
    @boutonValider = Gtk::Button.new(Gtk::Stock::OK)

    @boiteBoutons.pack_start(@boutonAnnuler, true, true, 0)
    @boiteBoutons.pack_start(@boutonValider, true, true, 0)

    # signaux des boutons
    
    @boutonAnnuler.signal_connect('clicked') do
      @fenetre.destroy()
    end
    
    @boutonValider.signal_connect('clicked') do
      partie.titre = @saisieTitre.text()
      partie.contenu = @nomFichier
      @fenetre.destroy()
    end
    
    @boutonApercu.signal_connect('clicked') do
      image = selectionnerFichier()
      @apercu.file = image
    end
    
    # Ajout de toutes les boites a la fenetre
    @boiteFenetre.pack_start(@boiteTitre, false , false, 0)
    @boiteFenetre.pack_start(@labelContenu, false , false, 0)
    @boiteFenetre.pack_start(@boiteApercu, false , false, 0)
    @boiteFenetre.pack_start(@boiteBoutons, false , false, 0)
    
    @fenetre.add(@boiteFenetre)
    @fenetre.show_all()
    
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
