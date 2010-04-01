# -*- coding: utf-8 -*-

##############################################################################
# Projet L3 Groupe 2 : classe FenetreConnexion
#
# ...
#
# derniere modification :	03/04/07, Romain
##############################################################################

class FenetreConnexion
	
#Variables
	
	# identifiant saisie par l'utilisateur
	@identifiantConnexion
	# mot de passe saisie par l'utilisateur
	@motDePasseConnexion
	
	def initialize()
		Gtk.init
		@gestUtilisateur = GestionnaireUtilisateur.new()
		
		# Creation de la fenetre
		@fenetreConnexion = Gtk::Window.new()
			# Titre de la fenetre
			@fenetreConnexion.set_title("Identification")
			# Icone de la fenetre
			@icone = Gdk::Pixbuf.new(PATH_IMAGES + "ORC2007.ico")
			@fenetreConnexion.icon = @icone
			# Taille originale de la fenetre
			@fenetreConnexion.set_default_size(300,100)
			# Reglage de la bordure
			@fenetreConnexion.border_width=3
			# Redimenssionement de la fenetre active
			@fenetreConnexion.set_resizable(false)
			# Centrage de l'application a son ouverture
			@fenetreConnexion.set_window_position(Gtk::Window::POS_CENTER_ALWAYS)
			@fenetreConnexion.signal_connect('destroy'){
				Gtk.main_quit
			}
		# Creation du contenu de la fenetre
		# @vBoxFenetreConnexion est le conteneur contenant tous les autres conteneurs de la fenetre
		@vBoxFenetreConnexion=Gtk::VBox.new()
			# creation de l'image
			@logo = Gtk::Image.new(PATH_IMAGES + "logo.jpg")
			
			# Creation du Label 
			@leLabel=Gtk::Label.new()
				@leLabel.set_markup("<b>Demande de Connexion</b>")
				@leLabel.set_justify(Gtk::JUSTIFY_CENTER)
			#Creation de la VBox Saisie (1 Box pour Identifiant,1 Box pour Mot de passe)
			@tableIdEtMdp = Gtk::Table.new(2,2,true)
				# Label et zone de saisie Identifiant
					@tableIdEtMdp.attach(Gtk::Label.new('Identifiant :'), 0, 1, 0, 1)
					@identifiantConnexion = Gtk::Entry.new
					@tableIdEtMdp.attach(@identifiantConnexion, 1, 2, 0, 1)
				# Label et zone de saisie Mot de Passe
					@tableIdEtMdp.attach(Gtk::Label.new('Mot de passe :'), 0, 1, 1, 2)
					@motDePasseConnexion = Gtk::Entry.new
					@motDePasseConnexion.visibility = false
					@tableIdEtMdp.attach(@motDePasseConnexion, 1, 2, 1, 2)
			#Creation de la HBox contenant les boutons "Valider", "Annuler", "Aide"
			@hBoxBouton=Gtk::HBox.new()
				@btnValider = Gtk::Button.new("Valider").set_image(Gtk::Image.new(Stock::APPLY,IconSize::LARGE_TOOLBAR))
				@btnValider.signal_connect('clicked'){
					if @identifiantConnexion.text() == "" && @motDePasseConnexion.text() == ""
						quickMessage("Veuillez saisir votre Identifiant\net\nVotre Mot De Passe")
					elsif @identifiantConnexion.text() == "" 
						quickMessage("Veuillez saisir votre Identifiant")
					elsif  @motDePasseConnexion.text() == ""
						quickMessage("Veuillez saisir votre Mot De Passe")
					else
						u = @gestUtilisateur.getUtilisateur(@identifiantConnexion.text())
						if u == nil
							quickMessage("L'identifiant que vous avez saisi est inexistant!")
						else
							if u.motDePasse == @motDePasseConnexion.text()
								@fenetreConnexion.destroy()
								FenetrePrincipale.new(u)
							else
								quickMessage("Le Mot De Passe que vous avez saisi est incorrect!")
							end
						end
					end
				}
				@hBoxBouton.pack_start(@btnValider)
				@btnAnnuler = Gtk::Button.new("RAZ").set_image(Gtk::Image.new(Stock::CLEAR,IconSize::LARGE_TOOLBAR))
				@btnAnnuler.signal_connect('clicked'){
					@identifiantConnexion.text = ""
					@motDePasseConnexion.text = ""
			}
				@hBoxBouton.pack_start(@btnAnnuler)
			# Creation du bouton Acceder en Mode Invite
			@btnInvite =Gtk::Button.new("Accéder en mode Invité").set_image(Gtk::Image.new(Stock::GO_FORWARD,IconSize::LARGE_TOOLBAR))
			@btnInvite.signal_connect('clicked'){
				@fenetreConnexion.destroy()
				FenetrePrincipale.new(Utilisateur.creerVisiteur())
			}
		# Construction de la Fenetre
		@vBoxFenetreConnexion.pack_start(@logo)
		@vBoxFenetreConnexion.pack_start(@leLabel)
		@vBoxFenetreConnexion.pack_start(@tableIdEtMdp)
		@vBoxFenetreConnexion.pack_start(@hBoxBouton)
		@vBoxFenetreConnexion.pack_start(@btnInvite)
		@fenetreConnexion.add(@vBoxFenetreConnexion)
		
		@fenetreConnexion.show_all
		Gtk.main
	end

end 


