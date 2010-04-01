# -*- coding: utf-8 -*-

require 'gtk2'

class FenetrePrincipale

	@documentOuvert # le document actuellement ouvert
	@partieSelectionnee # la partie actuellement selectionnee
	@commentaireSelectionne # le commentaire actuellement selectionnee
	@utilisateur # l'utilisateur courant du logiciel
	@widgetSelectionne
	@affichageToutComm # booleen indiquant si l'affichage de tous les commentaires est activé
	attr_accessor :utilisateur
	attr_accessor :documentOuvert
	attr_reader :partieSelectionnee

	def initialize(utilisateur)
		Gtk.init
		
		@utilisateur = utilisateur
		@actions = InterfaceActions.new(self)
		@fenetre = Gtk::Window.new()
		@fenetre.set_title("ORC " +  VERSION_LOG)
		@fenetre.window_position = Gtk::Window::POS_CENTER
		@icone = Gdk::Pixbuf.new(PATH_IMAGES + "ORC2007.ico")
		@fenetre.icon = @icone
		@fenetre.maximize()
		@fenetre.signal_connect('destroy'){ Gtk.main_quit() }
		@affichageToutComm = false
    
	# boite verticale contenant tous les widgets de la fenetre
	@boiteFenetre = Gtk::VBox.new()

	# boite horizontale des boutons du menu
	@boiteBoutonsMenu = Gtk::Toolbar.new()
	
	pos = 0
	
	# les boutons du menu en fonction du statut de l'utilisateur
	@btnMenuConnexion = Gtk::ToolButton.new(Gtk::Stock::DISCONNECT)
	@btnMenuConnexion.label = "Déconnexion"
	@btnMenuConnexion.signal_connect('clicked') {@actions.btnConnexion()}
	@boiteBoutonsMenu.insert(pos,@btnMenuConnexion)
	pos += 1
	
	@boiteBoutonsMenu.insert(pos, Gtk::SeparatorToolItem.new())
	pos += 1
	
	if @utilisateur.estVisiteur?()
		@btnMenuInscription = Gtk::ToolButton.new(Gtk::Stock::DIALOG_INFO)
		@btnMenuInscription.label = "Inscription"
		@btnMenuInscription.signal_connect('clicked') {@actions.btnInscription()}
		@boiteBoutonsMenu.insert(pos,@btnMenuInscription)
		pos += 1
	end

	if @utilisateur.estAuteur?()
		@btnMenuNouveau = Gtk::ToolButton.new(Gtk::Stock::NEW)
		@btnMenuNouveau.signal_connect('clicked') {@actions.btnNouveau()}
		@boiteBoutonsMenu.insert(pos,@btnMenuNouveau)
		pos += 1
	end
	
	@btnMenuOuvrirDoc = Gtk::ToolButton.new(Gtk::Stock::OPEN)
	@btnMenuOuvrirDoc.signal_connect('clicked') {@actions.btnOuvrirDoc()}
	@boiteBoutonsMenu.insert(pos,@btnMenuOuvrirDoc)
	pos += 1
	
	@btnMenuFermerDoc = Gtk::ToolButton.new(Gtk::Stock::CLOSE)
	@btnMenuFermerDoc.signal_connect('clicked') {@actions.btnFermerDoc()}
	@boiteBoutonsMenu.insert(pos,@btnMenuFermerDoc)
	pos += 1
	
	if @utilisateur.estAuteur?() or @utilisateur.estContributeur?()
		@btnMenuEnregistrer = Gtk::ToolButton.new(Gtk::Stock::FLOPPY)
		@btnMenuEnregistrer.label = "Enregistrer"
		@btnMenuEnregistrer.signal_connect('clicked') {
			@actions.btnEnregistrer()
			@barreEtat.push(1, "Votre document a bien été enregistré")
		}
		@boiteBoutonsMenu.insert(pos,@btnMenuEnregistrer)
		pos += 1
		
		@btnMenuEnregistrerVersion = Gtk::ToolButton.new(Gtk::Stock::SAVE_AS)
		@btnMenuEnregistrerVersion.label = "Enregistrer version"
		@btnMenuEnregistrerVersion.signal_connect('clicked') {
			@actions.btnEnregistrerVersion()
			@barreEtat.push(1, "Une nouvelle version du document a été créée")
		}
		@boiteBoutonsMenu.insert(pos,@btnMenuEnregistrerVersion)
		pos += 1
	end
	
	@boiteBoutonsMenu.insert(pos, Gtk::SeparatorToolItem.new())
	pos += 1
	
	@btnMenuImprimer = Gtk::ToolButton.new(Gtk::Image.new(PATH_IMAGES + "pdficon_large.gif"),"Exporter en PDF")
	@btnMenuImprimer.label = "Exporter en PDF"
	@btnMenuImprimer.signal_connect('clicked') {@actions.btnImprimer()}
	@boiteBoutonsMenu.insert(pos, @btnMenuImprimer)
	pos += 1
	
	@btnMenuImprimer2 = Gtk::ToolButton.new(Gtk::Image.new(PATH_IMAGES + "icone-word.jpg"),"Voir dans Word")
	@btnMenuImprimer2.label = "Voir dans Word"
	@btnMenuImprimer2.signal_connect('clicked') {@actions.btnImprimer2()}
	@boiteBoutonsMenu.insert(pos, @btnMenuImprimer2)
	pos += 1
	
	@boiteBoutonsMenu.insert(pos, Gtk::SeparatorToolItem.new())
	pos += 1
	
	if @utilisateur.estAdministrateur?()
		@btnMenuAdmin = Gtk::ToolButton.new(Gtk::Stock::PREFERENCES) 
		@btnMenuAdmin.label = "Admin"
		@btnMenuAdmin.signal_connect('clicked') {@actions.btnAdmin()}
		@boiteBoutonsMenu.insert(pos, @btnMenuAdmin)
		pos += 1
	end

	if @utilisateur.estAuteur?()   
		@btnMenuAuteur = Gtk::ToolButton.new(Gtk::Stock::PREFERENCES) 
		@btnMenuAuteur.label = "Auteur"
		@btnMenuAuteur.signal_connect('clicked') {@actions.btnAuteur()}
		@boiteBoutonsMenu.insert(pos, @btnMenuAuteur)
		pos += 1
	end

	if @utilisateur.estVisiteur?() == false   
		@btnMenuMesDonnees = Gtk::ToolButton.new(Gtk::Stock::HOME) 
		@btnMenuMesDonnees.label = "Mes Donnees"
		@btnMenuMesDonnees.signal_connect('clicked') {@actions.btnMesDonnees()}
		@boiteBoutonsMenu.insert(pos, @btnMenuMesDonnees)	    
		pos += 1
		
		@btnMenuMessagerie = Gtk::ToolButton.new(Gtk::Stock::DIALOG_INFO) 
		@btnMenuMessagerie.label = "Messagerie"
		@btnMenuMessagerie.signal_connect('clicked') {@actions.btnMessagerie()}
		@boiteBoutonsMenu.insert(pos, @btnMenuMessagerie)
		pos += 1
	end

	@btnMenuAide = Gtk::ToolButton.new(Gtk::Stock::HELP)
	@btnMenuAide.signal_connect('clicked') {@actions.btnAide()}
	@boiteBoutonsMenu.insert(pos, @btnMenuAide)
	pos += 1

	@btnMenuAPropos = Gtk::ToolButton.new(Gtk::Stock::ABOUT)
	@btnMenuAPropos.signal_connect('clicked') {@actions.btnAPropos()}
	@boiteBoutonsMenu.insert(pos, @btnMenuAPropos)	    
	pos += 1
	
	# test onglets visibles    
	@btnMenuOnglets = Gtk::ToggleToolButton.new(Gtk::Stock::PROPERTIES)
	@btnMenuOnglets.label = "Onglets"
	@btnMenuOnglets.active = true
	@btnMenuOnglets.signal_connect('toggled') do
		if @onglets.visible?
			@onglets.visible = false
		else 
			@onglets.visible = true
		end
	end

	# fin test

	# test commentaires visibles

	@btnMenuCommentaires = Gtk::ToggleToolButton.new(Gtk::Stock::PROPERTIES)
	@btnMenuCommentaires.label = "Commentaires"
	@btnMenuCommentaires.active = true
	@btnMenuCommentaires.signal_connect('toggled') do
		if @boitePartieCommentaire.visible?
			@boitePartieCommentaire.visible = false
		else 
			@boitePartieCommentaire.visible = true
		end
	end

	# fin test
	
	@btnMenuQuitter = Gtk::ToolButton.new(Gtk::Stock::QUIT)
	@btnMenuQuitter.signal_connect('clicked') {@actions.btnQuitter()}
	
	
	@boiteBoutonsMenu.insert(pos, Gtk::SeparatorToolItem.new())
	pos += 1
	
	# test onglets
	@boiteBoutonsMenu.insert(pos, @btnMenuOnglets)
	pos += 1
	# test commentaires
	@boiteBoutonsMenu.insert(pos, @btnMenuCommentaires)
	pos += 1
	
	@boiteBoutonsMenu.insert(pos, Gtk::SeparatorToolItem.new())
	pos += 1
	
	@boiteBoutonsMenu.insert(pos, @btnMenuQuitter)
	pos += 1
	
	# ajout de la boite du menu a la fenetre
	@boiteFenetre.pack_start(@boiteBoutonsMenu,false,false,0)

	# boite horizontale contenant le reste
	@boiteReste = Gtk::HPaned.new()

	# boite verticale contenant ce qui concerne une partie
	# (commentaire, boutons d'actions et affichage partie)
	@boitePartie = Gtk::VPaned.new()

	# boite verticale contenant le titre de la partie sélectionnée, 
	# l'affichage des parties et les boutons d'actions
	@boiteTitrePartie = Gtk::VBox.new()
	@lblTitrePartie = Gtk::Label.new("")
	@zoneAffichage = Gtk::VBox.new()

	@scrollAffichageParties = Gtk::ScrolledWindow.new()
	hAdjust = Gtk::Adjustment.new(15, 50, 130, 3, 5, 130)
	vAdjust = Gtk::Adjustment.new(15, 50, 130, 3, 5, 150)
	@affichagesPartie = Gtk::Viewport.new(hAdjust, vAdjust)
	@scrollAffichageParties.add(@affichagesPartie)
	@affichagesPartie.add(@zoneAffichage)

	@boiteBoutonsPartie = Gtk::Toolbar.new()
	
	pos = 0
	
	@btnPartieMonter = Gtk::ToolButton.new(Gtk::Stock::GO_UP)
	@btnPartieMonter.label = "Monter"
	@btnPartieMonter.signal_connect('clicked') {@actions.btnPartieMonter(@partieSelectionnee, @widgetSelectionne)}

	@btnPartieDescendre = Gtk::ToolButton.new(Gtk::Stock::GO_DOWN)
	@btnPartieDescendre.label = "Descendre"
	@btnPartieDescendre.signal_connect('clicked') {@actions.btnPartieDescendre(@partieSelectionnee, @widgetSelectionne)}

	@btnPartieInserer = Gtk::ToolButton.new(Gtk::Stock::ADD)
	@btnPartieInserer.label = "Inserer"
	@btnPartieInserer.signal_connect('clicked') {@actions.btnPartieInserer(@partieSelectionnee, @widgetSelectionne)}

	@btnPartieEditer = Gtk::ToolButton.new(Gtk::Stock::EDIT)
	@btnPartieEditer.label = "Editer"
	@btnPartieEditer.signal_connect('clicked') {@actions.btnPartieEditer(@partieSelectionnee)}

	@btnPartieSupprimer = Gtk::ToolButton.new(Gtk::Stock::DELETE)
	@btnPartieSupprimer.label = "Supprimer"
	@btnPartieSupprimer.signal_connect('clicked') {@actions.btnPartieSupprimer(@partieSelectionnee, @widgetSelectionne)}

	@btnPartieVerrouiller = Gtk::ToolButton.new(Gtk::Stock::DIALOG_AUTHENTICATION)
	@btnPartieVerrouiller.label = "Verrouiller"
	@btnPartieVerrouiller.signal_connect('clicked') {@actions.btnPartieVerrouiller(@partieSelectionnee)}

	# les boutons d'actions sur la partie
	if !@utilisateur.estVisiteur? && !@utilisateur.estAdministrateur?()
		@boiteBoutonsPartie.insert(pos, @btnPartieMonter)
		pos += 1
		@boiteBoutonsPartie.insert(pos, @btnPartieDescendre)   
		pos += 1
		@boiteBoutonsPartie.insert(pos, @btnPartieInserer)   
		pos += 1
		@boiteBoutonsPartie.insert(pos, @btnPartieEditer)    
		pos += 1
		@boiteBoutonsPartie.insert(pos, @btnPartieSupprimer)
		pos += 1
	end

	if @utilisateur.estAuteur?()
		@boiteBoutonsPartie.insert(pos, @btnPartieVerrouiller)
		pos += 1
	end

	@btnPartieCommenter = Gtk::ToolButton.new(Gtk::Stock::PASTE)
	@btnPartieCommenter.label = "Commenter"
	@btnPartieCommenter.signal_connect('clicked') {@actions.btnPartieCommenter(@partieSelectionnee,@utilisateur)}
	@boiteBoutonsPartie.insert(pos, @btnPartieCommenter)
	pos += 1
  
  @frameBoutonsPartie = Gtk::Frame.new("Actions sur les parties")
  @frameBoutonsPartie.add(@boiteBoutonsPartie)
  
  @boiteBoutonsCommentaire = Gtk::Toolbar.new()
  @btnCommSupprimer = Gtk::ToolButton.new(Gtk::Stock::DELETE)
  @btnCommSupprimer.label = "Supprimer"
  @btnCommSupprimer.signal_connect('clicked') do
    if @commentaireSelectionne != nil
      supprimerCommentaire(@commentaireSelectionne.partie, @commentaireSelectionne)
    end
  end
  
  @btnCommAfficherTous = Gtk::ToggleToolButton.new(Gtk::Stock::DND_MULTIPLE)
  @btnCommAfficherTous.label = "Tous les commentaires"
  @btnCommAfficherTous.signal_connect('toggled') do |w|
    if w.active?
      self.afficherTousLesCommentaires()
    else
      @affichageToutComm = false
      self.viderCommentaires()
      if @partieSelectionnee != nil
        afficherCommentaires(@partieSelectionnee)
      end
    end
  end
  
  @boiteBoutonsCommentaire.add(@btnCommAfficherTous)
  @boiteBoutonsCommentaire.add(@btnCommSupprimer)
  
  @frameBoutonsCommentaire = Gtk::Frame.new("Actions sur les commentaires")
  @frameBoutonsCommentaire.add(@boiteBoutonsCommentaire)

  @boutonsCommParties = Gtk::HBox.new()
  @boutonsCommParties.pack_start(@frameBoutonsPartie, true, true, 0)
  @boutonsCommParties.pack_start(@frameBoutonsCommentaire, true, true, 0)
  
  @boiteTitrePartie.pack_start(@lblTitrePartie, false, false, 0)
	@boiteTitrePartie.pack_start(@scrollAffichageParties, true, true, 0)
	@boiteTitrePartie.pack_start(@boutonsCommParties, false, false, 0)

	# boite concernant les commentaires
	@boitePartieCommentaire = Gtk::VBox.new()

	@scrollAffichageParties = Gtk::ScrolledWindow.new()
	hAdjust = Gtk::Adjustment.new(15, 50, 130, 3, 5, 130)
	vAdjust = Gtk::Adjustment.new(15, 50, 130, 3, 5, 150)
	@affichagesPartie = Gtk::Viewport.new(hAdjust, vAdjust)
	@scrollAffichageParties.add(@affichagesPartie)
	@affichagesPartie.add(@zoneAffichage)

	@lblCommentaire = Gtk::Label.new("Commentaires sur cette partie")
	@affichageCommentaires = Gtk::VBox.new()

	@scrollAffichageCommentaires = Gtk::ScrolledWindow.new()
	hAdjustComm = Gtk::Adjustment.new(15, 50, 130, 3, 5, 130)
	vAdjustComm = Gtk::Adjustment.new(75, 50, 30, 3, 5, 30)
	@viewAffichagesCommentaires = Gtk::Viewport.new(hAdjustComm, vAdjustComm)
	@scrollAffichageCommentaires.add(@viewAffichagesCommentaires)
	@viewAffichagesCommentaires.add(@affichageCommentaires)

	@boitePartieCommentaire.pack_start(@lblCommentaire, false, false, 0)
	@boitePartieCommentaire.pack_start(@scrollAffichageCommentaires, true, true, 0)

	# ajout a la boite partie de la boite concernant une partie et ses actions
	@boitePartie.pack1(@boiteTitrePartie, true, true)

	# ajout a la boite partie de la boite concernant les commentaires
	@boitePartie.pack2(@boitePartieCommentaire, false, true)

	# ajout de la boite reste à la boite partie
	@boiteReste.pack1(@boitePartie, true, true)

	# création des onglets
	@onglets = Gtk::Notebook.new()

	@boiteOngletPlan = Gtk::VBox.new()
	@boiteOngletHistorique = Gtk::VBox.new()
	@boiteOngletProprietes = Gtk::VBox.new()

	@labelTitreDoc = Gtk::Label.new()
	@labelTitreDoc.set_markup("<i>Titre du document</i>")
	@boiteOngletPlan.pack_start(@labelTitreDoc, false,false,0)

	######### Onglet Plan #############

	# UneHBox pour  le treeView
	maHBoxF3 = HBox.new(false, 5)
	#une HBox pour les bouton
	maHBox=HBox.new(false,5)

	# Une structure de liste pour stocker les données
	@listePlan = ListStore.new(Integer, String,String)
	# ajouter un élément à la source
	self.remplirPlan()

	# un TreeView pour visualiser les données de la liste
	sourceListeF3 = TreeView.new(@listePlan)

	sourceListeF3.selection.mode = SELECTION_MULTIPLE
	# Les 'renderer' permettent de préciser comment afficher les données
	renderer = CellRendererText.new
	renderer.foreground = "red"
	# On utilise Pango pour obtenir le gras
	renderer.weight = Pango::FontDescription::WEIGHT_BOLD
	# Ajout d'une colonne utilisant ce rendu dans les deux listes
	# la liste source
	# Ajout d'uhe colonne identifiant
	cols1 = TreeViewColumn.new("Position", renderer, :text => 0)
	cols1.set_sort_column_id(0)
	sourceListeF3.append_column(cols1)
	# Ajout d'uhe colonne email
	cols2 = TreeViewColumn.new("Type", renderer, :text => 1)
	cols2.set_sort_column_id(1)
	sourceListeF3.append_column(cols2)
	# Ajout d'une colonne statut
	cols3 = TreeViewColumn.new("Titre", renderer, :text =>2)
	sourceListeF3.append_column(cols3)

	maHBoxF3.add(sourceListeF3)
	@boiteOngletPlan.add(maHBoxF3) 

	######### Onglet Historique #########

	# Une structure de liste pour stocker les données
	@listeHistorique = Gtk::ListStore.new(Integer, String)
	# ajouter les éléments de l'historique
	self.remplirHistorique()

	# un TreeView pour visualiser les données de la liste
	sourceListeF1 = Gtk::TreeView.new(@listeHistorique)

	# Les 'renderer' permettent de préciser comment afficher les données
	renderer = Gtk::CellRendererText.new
	renderer.foreground = "red"
	# On utilise Pango pour obtenir le gras
	renderer.weight = Pango::FontDescription::WEIGHT_BOLD
	# Ajout d'une colonne utilisant ce rendu dans les deux listes
	# la liste source
	# Ajout d'uhe colonne identifiant
	cols1 = Gtk::TreeViewColumn.new("Version", renderer, :text => 0)
	cols1.set_sort_column_id(0)
	sourceListeF1.append_column(cols1)
	# Ajout d'uhe colonne email
	cols2 = Gtk::TreeViewColumn.new("Derniere date de modification", renderer, :text => 1)
	cols2.set_sort_column_id(1)
	sourceListeF1.append_column(cols2)

	@boiteOngletHistorique.add(sourceListeF1)
	#bouton valider
	valider = Button.new(Gtk::Stock::REVERT_TO_SAVED)

	valider.signal_connect('clicked') do
		if sourceListeF1.selection.selected != nil
			@documentOuvert = Document.charger(@documentOuvert.numero,sourceListeF1.selection.selected.get_value(0).to_i())
			chargementDoc()
		end
	end

	@boiteOngletHistorique.pack_start(valider,false,false,0)	  

	########## Onglet Proprietes ##############

	# nom auteur
	@labelNomAuteurProprietes = Gtk::Label.new()
	@labelNomAuteurProprietes.set_markup("<i>Auteur</i>")

	#membres du groupe (personne qui utilisent le document ) 

	# Une VBox pour la frame 2
	maVBoxF2=VBox.new(false,5)

	#
	frameGroupe=Frame.new("Liste des contributeurs")
	# UneHBox pour  le treeView
	maHBoxF2 = HBox.new(false, 5)
	#une HBox pour les bouton
	maHBox=HBox.new(false,5)

	# Une structure de liste pour stocker les données
	@listeProprietes = ListStore.new(String,String)
	# ajouter les élément à la liste
	self.remplirListeGroupe()

	# un TreeView pour visualiser les données de la liste
	sourceListeF2 = TreeView.new(@listeProprietes)

	sourceListeF2.selection.mode = SELECTION_MULTIPLE
	# Les 'renderer' permettent de préciser comment afficher les données
	renderer = CellRendererText.new
	renderer.foreground = "black"
	# On utilise Pango pour obtenir le gras
	renderer.weight = Pango::FontDescription::WEIGHT_BOLD
	# Les 'renderer' permettent de préciser comment afficher les données
	renderer2 = CellRendererText.new
	renderer2.foreground = "red"
	# On utilise Pango pour obtenir le gras
	renderer2.weight = Pango::FontDescription::WEIGHT_BOLD
	# Ajout d'une colonne utilisant ce rendu dans les deux listes
	# la liste source
	# Ajout d'uhe colonne identifiant
	cols1 = TreeViewColumn.new("Login", renderer, :text => 0)
	cols1.set_sort_column_id(0)
	sourceListeF2.append_column(cols1)
	# Ajout d'uhe colonne email
	cols2 = TreeViewColumn.new("Statut", renderer2, :text => 1)
	cols2.set_sort_column_id(1)
	sourceListeF2.append_column(cols2)
	maHBoxF2.add(sourceListeF2)
	maVBoxF2.add(maHBoxF2) 
	# fin du treeView groupe  
	frameGroupe.add(maVBoxF2)


	@boiteOngletProprietes.pack_start(@labelNomAuteurProprietes,false,false,0)
	@boiteOngletProprietes.pack_start(frameGroupe,true,true,0)

	##### Fin des onglets ########

	@onglets.append_page(@boiteOngletPlan)
	@onglets.set_tab_label_text(@boiteOngletPlan, "Plan")
	@onglets.append_page(@boiteOngletHistorique)
	@onglets.set_tab_label_text(@boiteOngletHistorique, "Historique")
	@onglets.append_page(@boiteOngletProprietes)
	@onglets.set_tab_label_text(@boiteOngletProprietes, "Proprietes")

	# ajout des onglets a la boite reste
	@boiteReste.pack2(@onglets, false, true)

	# ajout de la boite reste a la fenetre
	@boiteFenetre.add(@boiteReste)

	# barre d'état
	@barreEtat = Gtk::Statusbar.new()

	@boiteFenetre.pack_start(@barreEtat,false,false,0)

	@fenetre.add(@boiteFenetre)
	@fenetre.show_all
	Gtk.main 		# si on enlève le main, appli ne se lance plus
	end

	# méthodes d'affichage

	def afficherParties()
		# vide la boite des parties
		@zoneAffichage.each do |fils|
			@zoneAffichage.remove(fils)
		end

		# charge les parties pour les afficher
		@documentOuvert.eachPartie do |partie|
			part = partie.afficher()
			ajouterSignalPartie(part)
			@zoneAffichage.pack_start(part,false,false,2)
		end
		@zoneAffichage.show_all()
	end

	def afficherCommentaires(partie)
		if !@affichageToutComm
		      # charge les commentaires pour les afficher
		      partie.eachCommentaire() do |commentaire|
			comm = commentaire.afficher()
			comm.signal_connect('button-press-event') do |widget, event|
			  if event.event_type == Gdk::Event::BUTTON_PRESS and event.button == 1
			    @commentaireSelectionne = comm.contenu
			    @partieSelectionnee = nil
			    perteFocus()
			    @widgetSelectionne = widget
			    widget.modify_bg(Gtk::STATE_NORMAL, COULEUR_SELECTIONNE)
			  end
			end
			@affichageCommentaires.pack_start(comm,false,false,2)
		      end
		      @affichageCommentaires.show_all()
		end
	end

	def perteFocus()
		if @widgetSelectionne != nil
			@widgetSelectionne.modify_bg(Gtk::STATE_NORMAL, COULEUR_DESELECTIONNE)
		end
	end

	def monterPartie(widget)
		@zoneAffichage.reorder_child(widget, @zoneAffichage.child_get_property(widget, "position") - 1)
	end

	def descendrePartie(widget)
		@zoneAffichage.reorder_child(widget, @zoneAffichage.child_get_property(widget, "position") + 1)
	end

	def retirerPartie(widget)
		@zoneAffichage.remove(widget)
		@partieSelectionnee = nil
	end

	def affichagePartieVerrouillee()
		@btnPartieEditer.sensitive = false
		@btnPartieSupprimer.sensitive = false
		@btnPartieVerrouiller.label = "Deverrouiller"
	end

	def affichagePartieDeverrouillee()
		@btnPartieEditer.sensitive = true
		@btnPartieSupprimer.sensitive = true
		@btnPartieVerrouiller.label = "Verrouiller"
	end

	def insererPartie(widgetPartieSelec, widgetNouvellePartie)
		ajouterSignalPartie(widgetNouvellePartie)

		@zoneAffichage.pack_start(widgetNouvellePartie,false,false,2)
		@zoneAffichage.reorder_child(widgetNouvellePartie, @zoneAffichage.child_get_property(widgetPartieSelec, "position") + 1)
		@zoneAffichage.show_all()
	end

	def insererPartieEnFin(widget)
		ajouterSignalPartie(widget)

		@zoneAffichage.pack_start(widget,false,false,2)
		@zoneAffichage.show_all()
	end

	def ajouterSignalPartie(widget)
		widget.signal_connect('button-press-event') do |widget, event|
			if event.event_type == Gdk::Event::BUTTON_PRESS and event.button == 1
				partie = widget.contenu
				viderCommentaires()
				afficherCommentaires(partie)
				if(partie.verrou)
					affichagePartieVerrouillee()
				else
					affichagePartieDeverrouillee()
				end
				
				# rafraichir les boutons
				@lblTitrePartie.text = partie.titre()
				@partieSelectionnee = widget.contenu
				@commentaireSelectionne = nil
				perteFocus()
				@widgetSelectionne = widget
				widget.modify_bg(Gtk::STATE_NORMAL, COULEUR_SELECTIONNE)
			end
		end
		widget.signal_connect('enter-notify-event') do |widget, event|
			@barreEtat.push(1, "Partie : " + widget.contenu.titre)
		end
		widget.signal_connect('leave-notify-event') do |widget, event|
			razBarreEtat()
		end
	end

	def fermer()
		if @documentOuvert != nil && (utilisateurEstAuteur? || utilisateurEstContributeur)
			rep = msgConfirmationAvecAnnuler("Voulez-vous enregistrer les modifications avant de quitter ?")
			if rep == true
				@documentOuvert.enregistrer()
				@fenetre.destroy()
			elsif rep == false
				@fenetre.destroy()
			end
		else
			if(msgConfirmation("Voulez-vous vraiment quitter ?"))
				@fenetre.destroy()
			end
		end
	end

	def deconnexion()
		if @documentOuvert != nil && (utilisateurEstAuteur? || utilisateurEstContributeur)
			rep = msgConfirmationAvecAnnuler("Voulez-vous enregistrer les modifications avant de quitter ?")
			if rep == true
				@documentOuvert.enregistrer()
				@fenetre.destroy()
				FenetreConnexion.new()
			elsif rep == false
				@fenetre.destroy()
				FenetreConnexion.new()
			end
		else
			if(msgConfirmation("Voulez-vous vraiment vous deconnecter ?"))
				@fenetre.destroy()
				FenetreConnexion.new()
			end
		end
	end
	
	def modifierTexte()
		@widgetSelectionne.changerTexte(@widgetSelectionne.contenu.contenu())
		@lblTitrePartie.text = @widgetSelectionne.contenu.titre()
		@zoneAffichage.show_all()
	end

	def modifierImage()
		@lblTitrePartie.text = @widgetSelectionne.contenu.titre()
		@widgetSelectionne.changerImage(@widgetSelectionne.contenu.contenu())
		@zoneAffichage.show_all()
	end

	def utilisateurEstAuteur?()
		return @documentOuvert.auteur == @utilisateur
	end

	def utilisateurEstContributeur()
		return @documentOuvert.listeContributeurs.include?(@utilisateur)
	end

	def majBoutonsParties() 
		# utilisateur contributeur du doc ou auteur du doc
		if utilisateurEstContributeur() || utilisateurEstAuteur?()
			@btnPartieMonter.show
			@btnPartieDescendre.show
			@btnPartieEditer.show
			@btnPartieSupprimer.show
			@btnPartieInserer.show
		else
			# sinon c'est juste une personne qui ne peut que regarder
			@btnPartieMonter.hide
			@btnPartieDescendre.hide 
			@btnPartieEditer.hide 
			@btnPartieSupprimer.hide  
			@btnPartieInserer.hide
		end

		# utilisateur auteur du doc
		if utilisateurEstAuteur?()
			@btnPartieVerrouiller.show
			@btnCommSupprimer.show
		else
			@btnPartieVerrouiller.hide
			@btnCommSupprimer.hide
		end
	end

	def afficherTitreDoc()
		@partieSelectionnee = nil
		@fenetre.set_title("ORC "+ VERSION_LOG + " <" + @documentOuvert.titre + ">")
		@labelTitreDoc.set_markup("<b>" + @documentOuvert.titre + "</b>")
	end

	def afficherNomAuteur()
		@labelNomAuteurProprietes.set_markup("Auteur : #{documentOuvert.auteur.nom()}")
	end

	def remplirHistorique()
		@listeHistorique.clear()
		
		if @documentOuvert != nil
			#on charge la liste des version d'un document
			GestionnaireDocument.donnerDateDocument(@documentOuvert.numero).each do|idV, date|
				element = @listeHistorique.append()
				element[0] = idV
				element[1] = date.to_s()
			end	
		end
	end

	def remplirPlan()
		# vider l'affichage du plan
		@listePlan.clear()
		
		# mise a jour
		if @documentOuvert != nil
			n=1
			#on charge la liste des parties d'un document
			plan = @documentOuvert.listeParties.compact
			plan.each do |partie|
				# ajouter les  élément à la liste
				element = @listePlan.append()
				element[0] = n
				element[1] = partie.type();
				element[2] = partie.titre
				n+=1
			end
		end
	end

	def remplirListeGroupe()
		@listeProprietes.clear()
		
		if @documentOuvert != nil
			#liste des noms des contributeur
			listecontributeur = Array.new()
			@documentOuvert.listeContributeurs.compact.each do |util|
				nom = util.nom
				listecontributeur.push(nom)
			end
			
			#on charge la liste des contributeur d'un document
			utilisateurs = @documentOuvert.listeContributeurs()
			utilisateurs.each do |utilisateur|
				# ajouter un élément à la source
				element = @listeProprietes.append()
				element[0] = utilisateur.nom
				element[1] = utilisateur.statut
			end
		end
	end

	def chargementDoc()
		afficherParties()
		afficherTitreDoc()
		afficherNomAuteur()
		remplirPlan()
		remplirListeGroupe()
		remplirHistorique()
		viderCommentaires()
		razBarreEtat()
	end

	def viderCommentaires()
		# vide la boite des commentaires
	    if !@affichageToutComm
		@affichageCommentaires.each do |fils|
			@affichageCommentaires.remove(fils)
		end
	     end
	end

	def razBarreEtat()
		@barreEtat.push(1, "Document : " + @documentOuvert.titre +
			" compose de " + @documentOuvert.listeParties.size.to_s() + " partie(s)")
	end
	
  #gère l'affichage et l'action du bouton de suppression des commentaires
   def supprimerCommentaire(partie, commentaire)
    if (msgConfirmation("Voulez-vous vraiment supprimer ce commentaire ?"))
      partie.retirerCommentaire(commentaire)
      if !@affichageToutComm
        viderCommentaires()
        afficherCommentaires(partie)
      else
        razCommentaires()
        afficherTousLesCommentaires()
      end
      @affichageCommentaires.show_all()
    end
  end
  
  def afficherTousLesCommentaires()
	if @documentOuvert != nil
		viderCommentaires()
		@documentOuvert.eachPartie do |partie|
			afficherCommentaires(partie)
		end
		@affichageToutComm = true
	end
  end

  def razCommentaires()
    @affichageCommentaires.each do |fils|
        @affichageCommentaires.remove(fils)
    end
  end
  
  
  def razParties()
	@zoneAffichage.each do |p|
		@zoneAffichage.remove(p)
	end
  end

  def razTitreDoc()
	@labelTitreDoc.set_markup("")
	@fenetre.set_title("ORC " +  VERSION_LOG)
  end
  
  def razTitrePartie()
	@lblTitrePartie.text = ""
  end

  def razNomAuteur()
	@labelNomAuteurProprietes.text = ""
  end
  
  def razTotale()
	@partieSelectionnee = nil
	@widgetSelectionne = nil
	@CommentaireSelectionne = nil
	# vider parties
	razParties()
	# vider commentaires
	razCommentaires()
	# vider plan
	@listePlan.clear()
	# vider historique
	@listeHistorique.clear()
	# vider proprietes
	@listeProprietes.clear()
	# vider barre d'etat
	@barreEtat.push(1, "")
	# vider titre document
	razTitreDoc()
	# vider titre partie
	razTitrePartie()
  end

end
