require 'gtk2'


class FenetreNouveauDoc

 @document
 @utilisateur
 attr_reader :document

 def initialize(utilisateur)
   Gtk.init

   @utilisateur = utilisateur
   @fenetre = Gtk::Window.new()
   @fenetre.title = "Nouveau document"
   @fenetre.set_default_size(350,250)
   @fenetre.window_position = Gtk::Window::POS_CENTER
   @fenetre.modal = true

   @boiteFenetre = Gtk::VBox.new()

   # Titre
   @boiteTitre = Gtk::HBox.new()

   @labelTitre = Gtk::Label.new("Titre : ")
   @saisieTitre = Gtk::Entry.new()

   @boiteTitre.pack_start(@labelTitre, false, false, 0)
   @boiteTitre.pack_start(@saisieTitre, true, true, 0)

   # Visibilite
   @boiteVisibilite = Gtk::HBox.new()

   @labelVisibilite = Gtk::Label.new("Visibilite : ")
   @saisieVisibilite = Gtk::CheckButton.new("Publique")

   @boiteVisibilite.pack_start(@labelVisibilite, false, false, 0)
   @boiteVisibilite.pack_start(@saisieVisibilite, false, false, 0)

   # Label Description
   @labelDescription = Gtk::Label.new("Description :")

   # Saisie Description
   @saisieDescription = Gtk::TextView.new()

   # Boutons
   @boiteBoutons = Gtk::HBox.new()

   @boutonAnnuler = Gtk::Button.new(Gtk::Stock::CANCEL)
   @boutonValider = Gtk::Button.new(Gtk::Stock::OK)

   @boiteBoutons.pack_start(@boutonAnnuler, true, true, 0)
   @boiteBoutons.pack_start(@boutonValider, true, true, 0)

   # Ajout de toutes les boites a la fenetre
   @boiteFenetre.pack_start(@boiteTitre, false , false, 0)
   @boiteFenetre.pack_start(@boiteVisibilite, false , false, 0)
   @boiteFenetre.pack_start(@labelDescription, false , false, 0)
   @boiteFenetre.pack_start(@saisieDescription, true , true, 3)
   @boiteFenetre.pack_start(@boiteBoutons, false , false, 0)

   # Signaux
   @fenetre.signal_connect('destroy') do
     Gtk.main_quit()
   end

   @boutonValider.signal_connect('clicked') do
	#verification doc existe deja (meme titre, meme auteur)
	docValide = true
	@utilisateur.donnerDocumentsCrees.each do |d|
		if d.titre == @saisieTitre.text()
			quickMessage("Vous avez deja cree un document avec ce titre.")
			docValide = false
			break
		end
	end
	
	if docValide
		if @saisieVisibilite.active?()
			@document = Document.creer(GestionnaireDocument.donnerNumeroDocumentLibre(), @saisieTitre.text(), true, @saisieDescription.buffer.text,@utilisateur)
		else
			@document = Document.creer(GestionnaireDocument.donnerNumeroDocumentLibre(), @saisieTitre.text(), false, @saisieDescription.buffer.text,@utilisateur)
		end
		@fenetre.destroy()
	end
    end
    
   @boutonAnnuler.signal_connect('clicked') do
     @fenetre.destroy()
   end

   @fenetre.add(@boiteFenetre)
    
   @fenetre.show_all()
   Gtk.main
 end

end
#~ FenetreNouveauDoc.new(Utilisateur.creerVisiteur())
