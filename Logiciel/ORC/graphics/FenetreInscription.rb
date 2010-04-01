# -*- coding: utf-8 -*-


##############################################################################
# Projet L3 Groupe 2 : classe FenetreInscription
#
#
# derni�re modification :	03/04/07, Romain
# 
##############################################################################

require 'gtk2'
include Gtk

class FenetreInscription
	
	def initialize()
		
		Gtk.init
		
		@gestUtilisateur = GestionnaireUtilisateur.new().chargerUtilisateurs()
		@msgAdmin = MessagerieAdmin.new().chargerMessagerie()
		
		@monApp = Window.new
		@monApp.modal = true
		# Titre de la fen�tre
		@monApp.set_title("Inscription")
		# Taille de la fen�tre
		@monApp.set_default_size(200,500)
		# Rglage de la bordure
		@monApp.border_width=5
		# On ne peut pas redimensionner
		@monApp.set_resizable(false)
		# L'application est toujours centr�e
		@monApp.set_window_position(Window::POS_CENTER_ALWAYS)

		# Cr�ation du Layout
		maTable = Table.new(7, 2, false)
		@monApp.add(maTable)

		# Cation des champs de saisi
		#idientifiant
		maTable.attach(Label.new('Identifiant'),
					left = 0, right = 1,
					top = 0, bottom = 1,
					xopt = EXPAND|FILL, 
					yopt = EXPAND|FILL, 
					xpad = 0, ypad = 0
		)
		entryNom = Entry.new()
		maTable.attach(entryNom,
					left = 1, right = 2,
					top = 0, bottom = 1,
					xopt = EXPAND|FILL, 
					yopt = EXPAND|FILL, 
					xpad = 0, ypad = 0
		)
		
		#mot de passe1
		maTable.attach(Label.new('Mot de passe'),
					left = 0, right = 1,
					top = 1, bottom = 2,
					xopt = EXPAND|FILL, 
					yopt = EXPAND|FILL, 
					xpad = 0, ypad = 0
		)
		entryMdp1 = Entry.new().set_visibility(false)
		maTable.attach(entryMdp1,
					left = 1, right = 2,
					top = 1, bottom = 2,
					xopt = EXPAND|FILL, 
					yopt = EXPAND|FILL, 
					xpad = 0, ypad = 0
		)

		
		#mot de passe2
		maTable.attach(Label.new('Mot de passe'),
					left = 0, right = 1,
					top = 2, bottom = 3,
					xopt = EXPAND|FILL, 
					yopt = EXPAND|FILL, 
					xpad = 0, ypad = 0
		)
		entryMdp2 = Entry.new().set_visibility(false)
		maTable.attach(entryMdp2,
					left = 1, right = 2,
					top = 2, bottom = 3,
					xopt = EXPAND|FILL, 
					yopt = EXPAND|FILL, 
					xpad = 0, ypad = 0
		)
		
		
		#mail
		maTable.attach(Label.new('Adresse mail'),
					left = 0, right = 1,
					top = 3, bottom = 4,
					xopt = EXPAND|FILL, 
					yopt = EXPAND|FILL, 
					xpad = 0, ypad = 0
		)
		entryMail = Entry.new()
		maTable.attach(entryMail,
					left = 1, right = 2,
					top = 3, bottom = 4,
					xopt = EXPAND|FILL, 
					yopt = EXPAND|FILL, 
					xpad = 0, ypad = 0
		)
		
		
		
		#statut
		hbStatut = HBox.new(false, 2)
		
		maTable.attach(Label.new('Statut désiré'),
					left = 0, right = 1,
					top = 4, bottom = 5,
					xopt = EXPAND|FILL, 
					yopt = EXPAND|FILL, 
					xpad = 0, ypad = 0
		)
		maComboBox = ComboBox.new(true)
		STATUTS.each{ |s| maComboBox.append_text(s) }
		maComboBox.active = 0
		
		maTable.attach(maComboBox,
					left = 1, right = 2,
					top = 4, bottom = 5,
					xopt = EXPAND|FILL, 
					yopt = EXPAND|FILL, 
					xpad = 0, ypad = 0
		)
		
		#message
		maTable.attach(Label.new('Message'),
					left = 0, right = 1,
					top = 5, bottom = 6,
					xopt = EXPAND|FILL, 
					yopt = EXPAND|FILL, 
					xpad = 0, ypad = 0
		)
		entryMessage = TextView.new().set_wrap_mode(TextTag::WRAP_WORD)
		maTable.attach(entryMessage,
					left = 1, right = 2,
					top = 5, bottom = 6,
					xopt = EXPAND|FILL, 
					yopt = EXPAND|FILL, 
					xpad = 0, ypad = 0
		)
		
		
		#boutons
		btnQuitter = Button.new("Fermer").set_image(Gtk::Image.new(Stock::QUIT,IconSize::LARGE_TOOLBAR))
		btnValider = Button.new("Valider").set_image(Gtk::Image.new(Stock::APPLY,IconSize::LARGE_TOOLBAR))
		
		maTable.attach(btnQuitter,
					left = 0, right = 1,
					top = 6, bottom = 7,
					xopt = EXPAND|FILL, 
					yopt = EXPAND|FILL, 
					xpad = 2, ypad = 2
		)
		maTable.attach(btnValider,
					left = 1, right = 2,
					top = 6, bottom = 7,
					xopt = EXPAND|FILL, 
					yopt = EXPAND|FILL, 
					xpad = 2, ypad = 2
		)
		
		
		# Quand la fen�tre est d�truite il faut quitter
		@monApp.signal_connect('destroy') { Gtk.main_quit  }

		btnQuitter.signal_connect('clicked') { @monApp.destroy() }
		
		btnValider.signal_connect('clicked') do
			nom = entryNom.text.strip
			mdp1 = entryMdp1.text.strip
			mdp2 = entryMdp2.text.strip
			mail = entryMail.text.strip
			message = entryMessage.buffer.text.strip
			
			
			msg = ""
			msg += "Il faut rentrer un identifiant.\n" if nom == ""
			msg += "Il faut taper 2 fois le même mot de passe.\n" if mdp1 == "" || mdp2 == "" || mdp1 != mdp2
			msg += "Il faut rentrer une adresse mail.\n" if mail == ""
			
			if msg != ""
				quickMessage(msg)
			else
				if @gestUtilisateur.getUtilisateur(nom) == nil
					idLibre = @msgAdmin.donneIdLibre()
					statut = maComboBox.active_iter.get_value(0)
					d = DemandeInscription.new(idLibre,nom,mdp1,mail,message,statut)
					
					if @msgAdmin.recevoirMessage(d) == true
						quickMessage("Demande d'inscription acceptée.\n Vous recevrez un email pour confirmer la création du compte.")
						@monApp.destroy()
					else
						quickMessage("Demande d'inscription refusée.\n Une demande avec le même identifiant a déjà été recue.")
					end
				else
					quickMessage("L'identifiant #{nom} est déjà utilisé !")
					
				end
			end
		end
		
		
		@monApp.show_all()
		
		Gtk.main
	end
	
end
#~ FenetreInscription.new()
