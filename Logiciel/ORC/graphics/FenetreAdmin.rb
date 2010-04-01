# -*- coding: utf-8 -*-


##############################################################################
# Projet L3 Groupe 2 : classe FenetreAdmin
#
# Interface de l'admin
#
# dernière modification :	03/04/07, Romain
# 
# 
##############################################################################

require "gtk2"
include Gtk


class FenetreAdmin
	
	def initialize(utilisateur,document)
		
		Gtk.init
		
		@docCourant = document
		@utilisateur = utilisateur
		@msgAdmin = MessagerieAdmin.new()
		@gestUtilisateur = GestionnaireUtilisateur.new()
		
		maFenetreAdmin = Window.new()
		
		maFenetreAdmin.set_window_position(Window::POS_CENTER_ALWAYS)
		maFenetreAdmin.set_title("Administration").set_default_size(800, 400)
		maFenetreAdmin.signal_connect("destroy"){ Gtk.main_quit }
		
		
		############## DEBUT ONGLET 1
		
		
		maFrame1 = VBox.new()
		
		
		#le modele pour le treeview
		
		@modelUtilisateurs = ListStore.new(String, String, String, String)
		
		#le treeview
		treeview1 = TreeView.new(@modelUtilisateurs)
		treeview1.selection.mode = SELECTION_SINGLE
		
		#colonnes
		["Identifiant","Mot de passe","Adresse mail"].each_with_index do |obj,i|
			
			tex = CellRendererText.new()
			col = TreeViewColumn.new(obj, tex, :text => i).set_sort_column_id(i).set_resizable(true)
			treeview1.append_column(col)
		end
		
		tex = CellRendererCombo.new()
		tex.signal_connect("edited") do |*args| ## Data entry
			iter = treeview1.model.get_iter(args[1])
			iter[3] = args[2]
		end
			
		list = ListStore.new(String)
			
			STATUTS.each{ |i| iter = list.append(); iter[0] = i }
			
		tex.model = list          # Set values to select from
		tex.editable = true          # User can edit
		tex.has_entry = false         # User can't type in text
		tex.text_column = 0
			
			
		col = TreeViewColumn.new("Statut", tex, :text => 3)
		col.set_sort_column_id(3).set_resizable(true)
		treeview1.append_column(col)
		
		sw1 = ScrolledWindow.new(nil, nil)
		sw1.shadow_type = SHADOW_ETCHED_IN
		sw1.set_policy(POLICY_NEVER, POLICY_AUTOMATIC)
		sw1.add(treeview1)
		
		maHBox = HBox.new()
		
		btnAnnuler = Button.new("Recharger").set_image(Gtk::Image.new(Stock::REFRESH,IconSize::LARGE_TOOLBAR))
		btnSupprimer = Button.new("Supprimer le compte").set_image(Gtk::Image.new(Stock::DELETE,IconSize::LARGE_TOOLBAR))
		btnValider = Button.new("Sauvegarder les changements").set_image(Gtk::Image.new(Stock::SAVE,IconSize::LARGE_TOOLBAR))
		
		maHBox.pack_start(btnAnnuler, false, false, 5)
		maHBox.pack_start(btnSupprimer, false, false, 5)
		maHBox.pack_end(btnValider, false, false, 5)
		
		btnSupprimer.signal_connect("clicked") do
			if treeview1.selection.selected != nil
				nom = treeview1.selection.selected.get_value(0)
				message = "Voulez vous vraiment supprimer \nl'utilisateur \"" + nom +"\" ?"
				
				if msgConfirmation(message)
					@gestUtilisateur.supprimerUtilisateur(nom)
					self.majListeUtilisateurs()
				end
			end
		end
		
		btnAnnuler.signal_connect("clicked") do
			self.majListeUtilisateurs()
		end
		
		btnValider.signal_connect("clicked") do
			
			cpt = 0
			treeview1.model.each do |model,path,iter|
				
				iter = model.get_iter(path)
				
				nom = iter[0]
				statut = iter[3]
				u = @gestUtilisateur.getUtilisateur(nom)
				
				if u.nom == nom && u.statut != statut && nom != @utilisateur.nom
					cpt += 1
					
					u.devenirContributeur() if statut == STATUT_CONTRIBUTEUR	
					u.devenirAdministrateur() if statut == STATUT_ADMINISTRATEUR
					u.devenirAuteur() if statut == STATUT_AUTEUR
					
				end
			end
			self.majListeUtilisateurs()
			
			quickMessage(cpt.to_s + " compte(s) modifié(s).")
		end
		
		maFrameCreationCompte = Frame.new("Création compte")
		
		maVBox2 = VBox.new()
		
		maTable = Table.new(rows = 7, columns = 2, homogeneous = false)
		
		
		@entryIdentifiant = Entry.new()
		maTable.attach(Label.new("Identifiant"),
						left = 0, right = 1, top = 0, bottom = 1,
						xopt = EXPAND|FILL,
						yopt = EXPAND|FILL,
						xpad = 0, ypad = 0
		)
		
		maTable.attach(@entryIdentifiant,
						left = 1, right = 2, top = 0, bottom = 1,
						xopt = EXPAND|FILL,
						yopt = EXPAND|FILL,
						xpad = 0, ypad = 0
		)
		
		@entryMotDePasse1 = Entry.new().set_visibility(false)
		maTable.attach(Label.new("Mot de passe"),
						left = 0, right = 1, top = 1, bottom = 2,
						xopt = EXPAND|FILL,
						yopt = EXPAND|FILL,
						xpad = 0, ypad = 0
		)
		maTable.attach(@entryMotDePasse1,
						left = 1, right = 2, top = 1, bottom = 2,
						xopt = EXPAND|FILL,
						yopt = EXPAND|FILL,
						xpad = 0, ypad = 0
		)

		
		@entryMotDePasse2 = Entry.new().set_visibility(false)
		maTable.attach(Label.new("Retapez le mot de passe"),
						left = 0, right = 1, top = 2, bottom = 3,
						xopt = EXPAND|FILL,
						yopt = EXPAND|FILL,
						xpad = 0, ypad = 0
		)
		maTable.attach(@entryMotDePasse2,
						left = 1, right = 2, top = 2, bottom = 3,
						xopt = EXPAND|FILL,
						yopt = EXPAND|FILL,
						xpad = 0, ypad = 0
		)
		
		@entryMail = Entry.new()
		maTable.attach(Label.new("Adresse mail"),
						left = 0, right = 1, top = 3, bottom = 4,
						xopt = EXPAND|FILL,
						yopt = EXPAND|FILL,
						xpad = 0, ypad = 0
		)
		maTable.attach(@entryMail,
						left = 1, right = 2, top = 3, bottom = 4,
						xopt = EXPAND|FILL,
						yopt = EXPAND|FILL,
						xpad = 0, ypad = 0
		)
		
		
		@maComboBox = ComboBox.new(true)
		maTable.attach(Label.new("Statut"),
						left = 0, right = 1, top = 4, bottom = 5,
						xopt = EXPAND|FILL,
						yopt = EXPAND|FILL,
						xpad = 0, ypad = 0
		)
		maTable.attach(@maComboBox,
						left = 1, right = 2, top = 4, bottom = 5,
						xopt = EXPAND|FILL,
						yopt = EXPAND|FILL,
						xpad = 0, ypad = 0
		)
		
		STATUTS.each do |s| 
			@maComboBox.append_text(s) 
		end
		@maComboBox.active = 0
		btnRAZ = Button.new("RAZ").set_image(Gtk::Image.new(Stock::CLEAR,IconSize::LARGE_TOOLBAR))
		btnCreationCompte = Button.new("Création compte").set_image(Gtk::Image.new(Stock::ADD,IconSize::LARGE_TOOLBAR))
		
		
		maTable.attach(btnRAZ,
						left = 0, right = 1, top = 5, bottom = 6,
						xopt = EXPAND|FILL,
						yopt = EXPAND|FILL,
						xpad = 2, ypad = 2
		)
		maTable.attach(btnCreationCompte,
						left = 1, right = 2, top = 5, bottom = 6,
						xopt = EXPAND|FILL,
						yopt = EXPAND|FILL,
						xpad = 2, ypad = 2
		)
		
		maFrameCreationCompte.add(maTable)
		
		maFrame1.pack_start(sw1, expand = true, fill = true, padding = 5)
		maFrame1.pack_start(maHBox, false, false, 5)
		maFrame1.pack_start(HSeparator.new(), false, false, 0)
		maFrame1.pack_start(maFrameCreationCompte, false, false, 5)
		
		
		btnRAZ.signal_connect("clicked") do
			self.razChampsInscription()
		end
		
		btnCreationCompte.signal_connect("clicked") do
			self.creationCompte()
			self.majListeUtilisateurs()
		end
		
		##########		FIN ONGLET 1
		
		
		############## DEBUT ONGLET 2
		
		maFrame2 = VBox.new(homogeneous = false, spacing = nil)
		
		@modelDemandeInscriptions = ListStore.new(String, String, String, String, String, TrueClass, TrueClass, TrueClass, Integer)
		
		viewListeF2 = TreeView.new(@modelDemandeInscriptions)
		viewListeF2.selection.mode = SELECTION_SINGLE
		
		renderer1 = CellRendererToggle.new().set_radio(true)
		renderer1.signal_connect("toggled") do |cell,row_iter|
			iter = viewListeF2.model.get_iter(TreePath.new(row_iter))
			majRadioButtons(iter,5) if iter[5] == false
		end
		
		renderer2 = CellRendererToggle.new().set_radio(true)
		renderer2.signal_connect("toggled") do |cell,row_iter|
			iter = viewListeF2.model.get_iter(TreePath.new(row_iter))
			majRadioButtons(iter,6) if iter[6] == false	
		end
		
		renderer3 = CellRendererToggle.new().set_radio(true)
		renderer3.signal_connect("toggled") do |cell,row_iter|
			iter = viewListeF2.model.get_iter(TreePath.new(row_iter))
			majRadioButtons(iter,7) if iter[7] == false	
		end
		
		colonneAccepter = TreeViewColumn.new("Accepter", renderer1, :active => 5)
		colonneRefuser = TreeViewColumn.new("Refuser", renderer2, :active => 6)
		colonneNeRienFaire = TreeViewColumn.new("Ne rien faire", renderer3, :active => 7)
		
		[colonneAccepter,colonneRefuser,colonneNeRienFaire].each do |c|
			c.set_sizing(TreeViewColumn::FIXED).set_fixed_width(60)
		end
		
		viewListeF2.append_column(TreeViewColumn.new("Identifiant", CellRendererText.new(), :text => 0).set_resizable(true))
		viewListeF2.append_column(TreeViewColumn.new("Mot de passe", CellRendererText.new(), :text => 1).set_resizable(true))
		viewListeF2.append_column(TreeViewColumn.new("Adresse mail", CellRendererText.new(), :text => 2).set_resizable(true))
		viewListeF2.append_column(TreeViewColumn.new("Statut désiré", CellRendererText.new(), :text => 3).set_resizable(true))
		viewListeF2.append_column(TreeViewColumn.new("Message", CellRendererText.new(), :text => 4).set_resizable(true))
		viewListeF2.append_column(colonneAccepter)
		viewListeF2.append_column(colonneRefuser)
		viewListeF2.append_column(colonneNeRienFaire)
		
		leMessage = TextView.new().set_editable(false)
		leMessage.buffer.text = ""
		
		viewListeF2.signal_connect("cursor-changed") do |view|
			idMess = view.selection.selected.get_value(8)
			leMessage.buffer.text = @msgAdmin.getMessage(idMess).message
		end
		
		maHBox1 = HBox.new(homogeneous = false, spacing = nil)
		
		btnRecharger = Button.new("Recharger").set_image(Gtk::Image.new(Stock::REFRESH,IconSize::LARGE_TOOLBAR))
		btnValider = Button.new("Valider").set_image(Gtk::Image.new(Stock::APPLY,IconSize::LARGE_TOOLBAR))
		
		maHBox1.pack_start(btnRecharger, expand = false, fill = false, padding = 0)
		maHBox1.pack_end(btnValider, expand = false, fill = false, padding = 0)
		
		maFrame2.pack_start(viewListeF2, expand = true, fill = true, padding = 5)
		maFrame2.pack_start(HSeparator.new(), expand = false, fill = false, padding = 5)
		maFrame2.pack_start(leMessage, expand = true, fill = true, padding = 5)
		maFrame2.pack_start(maHBox1, expand = false, fill = false, padding = 5)
		
		
		btnRecharger.signal_connect("clicked") do
			self.majDemandesInscription()
		end
		
		btnValider.signal_connect("clicked") do
			self.gestionDemandes()
			self.majDemandesInscription()
		end
		
		############## FIN ONGLET 2
		
		############## DEBUT ONGLET 3
		
		maFrame3 = VBox.new()
		
		@modelDocs = ListStore.new(String, String, Integer, Integer, TrueClass, String, Integer)
		
		#le treeview
		treeview3 = TreeView.new(@modelDocs)
		treeview3.selection.mode = SELECTION_SINGLE
		
		#colonnes
		["Titre document","Auteur actuel","Nb parties","Nb contributeurs"].each_with_index do |obj,i|
			
			col = TreeViewColumn.new(obj, CellRendererText.new(), :text => i).set_sort_column_id(i).set_resizable(true)
			treeview3.append_column(col)
		end
		
		
		cell = CellRendererToggle.new()
		col = TreeViewColumn.new("Visibilité publique", cell, :active => 4).set_sort_column_id(4).set_resizable(true)
		treeview3.append_column(col)
		
		
		tex = CellRendererCombo.new()
		tex.signal_connect("edited") do |*args| 
			iter = treeview3.model.get_iter(args[1])
			iter[5] = args[2]
		end
		
		@modelAuteurs = ListStore.new(String)
		tex.model = @modelAuteurs       
		tex.editable = true      
		tex.has_entry = false       
		tex.text_column = 0
			
			
			
		col = TreeViewColumn.new("Nouvel auteur", tex, :text => 5).set_resizable(true)
		treeview3.append_column(col)
		
		
		maHBox1 = HBox.new()
		
		btnAnnuler = Button.new("Recharger").set_image(Gtk::Image.new(Stock::REFRESH,IconSize::LARGE_TOOLBAR))
		btnSupprimer = Button.new("Supprimer le document").set_image(Gtk::Image.new(Stock::DELETE,IconSize::LARGE_TOOLBAR))
		btnValider = Button.new("Sauvegarder les changements").set_image(Gtk::Image.new(Stock::SAVE,IconSize::LARGE_TOOLBAR))
		
		btnSupprimer.signal_connect("clicked") do
			if treeview3.selection.selected != nil
				id = treeview3.selection.selected.get_value(6)

				if @docCourant != nil && @docCourant.numero == id
					quickMessage("Ce document est actuellement utilisé, pour le supprimer veuillez le fermer.")
				else
					if msgConfirmation("Voulez vous vraiment supprimer ce document ?")
						GestionnaireDocument.supprimerDocument(id)
						self.majListeDocs()
					end
				end
			end
		end
		
		btnAnnuler.signal_connect("clicked") do |*args|
			self.majListeDocs()
		end
		
		btnValider.signal_connect("clicked") do |*args|
			self.gestionDocs()
			self.majListeDocs()
		end
		
		maHBox1.pack_start(btnAnnuler, expand = false, fill = false, padding = 5)
		maHBox1.pack_start(btnSupprimer, expand = false, fill = false, padding = 5)
		maHBox1.pack_end(btnValider, expand = false, fill = false, padding = 5)
		
		maFrame3.pack_start(treeview3, expand = true, fill = true, padding = 0)
		maFrame3.pack_start(maHBox1, expand = false, fill = false, padding = 5)
		
		
		############## FIN ONGLET 3
		
		mesOnglets = Notebook.new().set_scrollable(true)
		frameOnglet = {
			"Gestion Utilisateurs" => [maFrame1,:majListeUtilisateurs],
			"Demandes d'inscription" => [maFrame2,:majDemandesInscription],
			"Gestion Documents" => [maFrame3,:majListeDocs]
		}
		titreOnglet = [
			"Gestion Utilisateurs",
			"Demandes d'inscription",
			"Gestion Documents"
		]

		titreOnglet.each do |titre|
			frame = frameOnglet[titre][0]
			
			ongBox = HBox.new()
			ongBox.pack_start(Label.new(titre),false,false,0).show_all()
			
			mesOnglets.append_page_menu(frame,ongBox,Label.new(titre))
		end
		
		
		mesOnglets.signal_connect('switch-page') do |notebook,page,indexPage|
			symb = frameOnglet[titreOnglet[indexPage]][1]
			self.send(symb)
		end
		
		
		maFenetreAdmin.add(mesOnglets)
		maFenetreAdmin.show_all()
		
		Gtk.main
		
	end
	
	def gestionDocs()
		cpt = 0
		@modelDocs.each do |model,path,iter|
			
			iter = model.get_iter(path)
			idDoc = iter[6]
			newAuteur = iter[5]
			
			if newAuteur != "" && newAuteur != "Cliquez ici" && newAuteur != iter[1]
				cpt += 1
				
				doc = GestionnaireDocument.getDocument(idDoc)
				auteur = @gestUtilisateur.getUtilisateur(newAuteur)
				
				doc.changerAuteur(auteur)
			end
		end
		quickMessage(cpt.to_s + " changement(s) d'auteur effectué(s).")
		return self
	end
	
	def majDemandesInscription()
		
		@modelDemandeInscriptions.clear()
		
		@msgAdmin.chargerMessagerie()
		@msgAdmin.each do |d|
			iter = @modelDemandeInscriptions.append()
			iter[0] = d.expediteur
			iter[1] = d.motDePasse
			iter[2] = d.mail
			iter[3] = d.statutDemande
			iter[4] = d.message[0..20] + "..."
			iter[5] = false
			iter[6] = false
			iter[7] = true
			iter[8] = d.id
		end
	end
	
	def majListeDocs()
		@modelDocs.clear()
		@modelAuteurs.clear()
		
		GestionnaireDocument.eachDoc do |doc|
			iter = @modelDocs.append()
			iter[0] = doc.titre
			iter[1] = (doc.auteur == nil) ? "Non défini" : doc.auteur.nom
			iter[2] = doc.listeParties.compact().size()
			iter[3] = doc.listeContributeurs.compact().size()
			iter[4] = (doc.visibilitePublique == true) ? true : false
			iter[5] = "Cliquez ici"
			iter[6] = doc.numero
		end
		
		@gestUtilisateur.donnerAuteurs().each do |u|
			iter = @modelAuteurs.append()
			iter[0] = u
		end
	end
	
	def majListeUtilisateurs()
		
		@modelUtilisateurs.clear()
		@gestUtilisateur.chargerUtilisateurs().each do |u|
			
			next if u.nom == @utilisateur.nom
			iter = @modelUtilisateurs.append()
			iter[0] = u.nom
			iter[1] = u.motDePasse
			iter[2] = u.eMail
			iter[3] = u.statut
		end
	end
	
	def razChampsInscription()
		@entryIdentifiant.text = ""
		@entryMotDePasse1.text = ""
		@entryMotDePasse2.text = ""
		@entryMail.text = ""
		@maComboBox.active = 0
	end
	
	def creationCompte()
		
		identifiant = @entryIdentifiant.text.strip
		mdp1 = @entryMotDePasse1.text.strip
		mdp2 = @entryMotDePasse2.text.strip
		mail = @entryMail.text.strip
		statut = @maComboBox.active_text
		
		msg = ""
		msg += "Il faut rentrer un identifiant.\n" if identifiant == "" 
		msg += "Il faut rentrer 2 fois le même mot de passe.\n" if mdp1 == "" || mdp2 == "" || mdp1 != mdp2
		msg += "Il faut rentrer une adresse mail.\n" if mail == "" 
		
		if msg != ""
			quickMessage(msg)
		else
			if @gestUtilisateur.getUtilisateur(identifiant) == nil
			
				u = Utilisateur.creerContributeur(
								identifiant,
								mdp1,
								mail
				)
				
				u.devenirAuteur() if statut == STATUT_AUTEUR
				u.devenirAdministrateur() if statut == STATUT_ADMINISTRATEUR
				
				@gestUtilisateur.ajouterUtilisateur(u)
				self.razChampsInscription()
				return true
			else 
				quickMessage("L'identifiant \"" + identifiant + "\" existe déjà !")	
			end
		end
		return false
	end
	
	def majRadioButtons(iter,colonne)
		iter[colonne] ^= 1
		if colonne == 5
			colonne1 = 6; colonne2 = 7
		elsif colonne == 6
			colonne1 = 5; colonne2 = 7
		elsif colonne == 7
			colonne1 = 5; colonne2 = 6
		end
		iter[colonne1] ^= 1 if iter[colonne1] == iter[colonne]
		iter[colonne2] ^= 1 if iter[colonne2] == iter[colonne]
	end
	
	def gestionDemandes()
		
		cptDemandeAccepte = 0
		cptDemandeRefuse = 0
		msg = ""
		
		@modelDemandeInscriptions.each do |model,path,iter|
			
			iter = model.get_iter(path)
			idMess = iter[8]
			
			if iter[5] == true
				
				d = @msgAdmin.getMessage(idMess)
				statutDemande = d.statutDemande
				
				if @gestUtilisateur.getUtilisateur(d.expediteur) == nil
					u = Utilisateur.creerContributeur(
								d.expediteur,
								d.motDePasse,
								d.mail
					)
					
					u.devenirAuteur() if statutDemande == STATUT_AUTEUR
					u.devenirAdministrateur() if statutDemande == STATUT_ADMINISTRATEUR
					
					@gestUtilisateur.ajouterUtilisateur(u)
					@msgAdmin.supprimerMessage(idMess)
					
					cptDemandeAccepte += 1
				else 
					msg += "L'identifiant \"#{d.expediteur}\" existe déjà !\n"
				end
				
			elsif iter[6] == true
				cptDemandeRefuse += 1
				@msgAdmin.supprimerMessage(idMess)
			end
		end
		
		msg += "\n#{cptDemandeAccepte.to_s} demandes acceptées.\n"
		msg += "#{cptDemandeRefuse.to_s} demandes refusées."
		
		quickMessage(msg)
		
		return self
	end
	
end

