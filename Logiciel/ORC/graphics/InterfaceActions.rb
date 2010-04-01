# -*- coding: utf-8 -*-

class InterfaceActions
  
  @fenetrePrincipale
  
  # boutons du menu principal
  
  def initialize(fenetre)
    @fenetrePrincipale = fenetre
  end
  
  def btnConnexion()
	@fenetrePrincipale.deconnexion()
  end
  
  def btnInscription
    FenetreInscription.new()
  end
  
  def btnNouveau
    fen = FenetreNouveauDoc.new(@fenetrePrincipale.utilisateur())
    if fen.document != nil
      @fenetrePrincipale.documentOuvert = fen.document
      @fenetrePrincipale.afficherParties()
      @fenetrePrincipale.afficherTitreDoc()
      @fenetrePrincipale.afficherNomAuteur()
      @fenetrePrincipale.razBarreEtat()
      @fenetrePrincipale.majBoutonsParties()
    end
  end
  
  def btnOuvrirDoc
    fenDoc = FenetreOuvrirDoc.new(@fenetrePrincipale.utilisateur())
    # fendoc doit etre modale ou doit connaitre la fenetre principale
    if fenDoc.idDocument() != nil
	doc = Document.charger(fenDoc.idDocument)
	if doc.auteur != nil
		@fenetrePrincipale.documentOuvert = doc
		@fenetrePrincipale.chargementDoc()
		@fenetrePrincipale.majBoutonsParties()
	else
		quickMessage("Ce document n'a plus d'auteur. Veuillez contacter un administrateur.")
	end
    end
  end
  
  def btnFermerDoc()
	if @fenetrePrincipale.documentOuvert != nil
		if msgConfirmation("Etes-vous sur de vouloir fermer ce document ?")
			@fenetrePrincipale.documentOuvert = nil
			@fenetrePrincipale.razTotale()
		end
	end
  end
  
  def btnEnregistrer
    if @fenetrePrincipale.documentOuvert != nil
      @fenetrePrincipale.documentOuvert.enregistrer()
      @fenetrePrincipale.remplirHistorique()
    end
  end
  
  def btnEnregistrerVersion
    if @fenetrePrincipale.documentOuvert != nil
      @fenetrePrincipale.documentOuvert.enregistrerVersion()
      @fenetrePrincipale.remplirHistorique()
    end
  end
  
  def btnImprimer
  	if @fenetrePrincipale.documentOuvert != nil
		begin
			require "pdf/writer"
		rescue LoadError
			quickMessage("Il manque le module pdfWriter. Veuillez vous refere au manuel utilisateur.")
		else
			FenetreExportPDF.new(@fenetrePrincipale.documentOuvert)
		end
	end
  end
  
  def btnImprimer2
	if @fenetrePrincipale.documentOuvert != nil
		begin
			require "win32ole"
		rescue LoadError
			quickMessage("Cette fonctionnalité n'est accessible que sous Windows.")
		else
			FenetreExportWord.new(@fenetrePrincipale.documentOuvert)
		end
	end
  end

  
  def btnAdmin
    FenetreAdmin.new(@fenetrePrincipale.utilisateur(),@fenetrePrincipale.documentOuvert())
  end
  
  def btnAuteur
    if @fenetrePrincipale.utilisateur().donnerDocumentsCrees.empty?()
      dialog = Gtk::MessageDialog.new($main_app_window, 
                                Gtk::Dialog::DESTROY_WITH_PARENT,
                                Gtk::MessageDialog::INFO,
                                Gtk::MessageDialog::BUTTONS_CLOSE,
                                "Vous n'avez pas cree de document.")
      dialog.window_position = Gtk::Window::POS_CENTER 
      dialog.run
      dialog.destroy
    else
      FenetreAuteur.new(@fenetrePrincipale.utilisateur(), @fenetrePrincipale.documentOuvert())
      @fenetrePrincipale.remplirListeGroupe()
      #~ @fenetrePrincipale.remplirHistorique()
    end
  end
  
  def btnMesDonnees
    FenetreMesDonnees.new(@fenetrePrincipale.utilisateur())
  end
  
  def btnMessagerie
    FenetreMessagerie.new(@fenetrePrincipale.utilisateur())
  end
  
  def btnAide
    quickMessage("Vous pouvez trouver de l'aide dans le document Word...")
  end
  
  def btnAPropos
    aPropos = Gtk::AboutDialog.new()
    aPropos.window_position = Gtk::Window::POS_CENTER 
    aPropos.name = "ORC"
    aPropos.version = VERSION_LOG
    aPropos.comments = "Logiciel de travail collaboratif"
    aPropos.website = "www-iupmime.univ-lemans.fr"
    aPropos.authors = ["Nicolas Dupont","Rafik Bennacer","Xiana Ai","Guillaume Chauveau",
    "Romain Dervaux","Maxime Chagnolleau","Pierre Bertrand-Noel","Julien Saulou"]
    aPropos.documenters = ["Pierre Bertrand-Noel"]
    aPropos.logo = Gdk::Pixbuf.new(PATH_IMAGES + "logo.jpg")
    
    aPropos.run()
    aPropos.destroy()
  end
  
  def btnQuitter
    @fenetrePrincipale.fermer()
  end  
   
  # boutons du menu de gestion des parties

  def btnPartieMonter(partie, widget)
    if(partie != nil)
      if(@fenetrePrincipale.documentOuvert.monterPartie(partie))
        @fenetrePrincipale.monterPartie(widget)
        @fenetrePrincipale.remplirPlan()
      end
    end
  end
  
  def btnPartieDescendre(partie, widget)
    if(partie != nil)
      if(@fenetrePrincipale.documentOuvert.descendrePartie(partie))
        @fenetrePrincipale.descendrePartie(widget)
        @fenetrePrincipale.remplirPlan()
      end
    end
  end
  
  def btnPartieInserer(partiePrecedente, widget)
    if @fenetrePrincipale.documentOuvert != nil
	    f = FenetreInsererPartie.new()
	    part = f.partieRetournee()
      if part != nil
        @fenetrePrincipale.documentOuvert.insererPartieApres(part, partiePrecedente)
        if partiePrecedente != nil
          @fenetrePrincipale.insererPartie(widget, part.afficher())
        else
          @fenetrePrincipale.insererPartieEnFin(part.afficher())
        end
        @fenetrePrincipale.remplirPlan()
        @fenetrePrincipale.razBarreEtat()
      end
    end
  end
  
  def btnPartieEditer(partie)
    if partie != nil
      partie.modifier(@fenetrePrincipale)
      @fenetrePrincipale.remplirPlan()
    end
  end
  
  def btnPartieCommenter(partie, utilisateur)
    if partie != nil
      FenetreCommenter.new(partie, utilisateur)
      @fenetrePrincipale.viderCommentaires()
      @fenetrePrincipale.afficherCommentaires(partie)
    end
  end
  
  def btnPartieSupprimer(partie, widget)
    if(partie != nil)
      if (msgConfirmation("Voulez-vous vraiment supprimer cette partie ?"))
	      @fenetrePrincipale.documentOuvert.retirerPartie(partie)
	      @fenetrePrincipale.retirerPartie(widget)
	      @fenetrePrincipale.viderCommentaires()
	      @fenetrePrincipale.afficherCommentaires(partie)
	      @fenetrePrincipale.remplirPlan()
	      @fenetrePrincipale.razBarreEtat()
       end
    end
  end
  
  def btnPartieVerrouiller(partie)
    if(partie != nil)
      if(partie.verrou)
        partie.deverrouiller()
      else
        partie.verrouiller()
      end
    end
  end
  
end
