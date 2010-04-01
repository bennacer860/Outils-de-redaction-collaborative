# -*- coding: utf-8 -*-

##############################################################################
# Projet L3 Groupe 2 : classe FenetreMessagerie
#
# Interface de la messagerie
#
# derniÃ¨re modification :	03/04/07, Romain
#
##############################################################################


require 'gtk2'
include Gtk
class FenetreMessagerie
	
	@utilisateur       #Utilisateur : utilisateur courant
	@messagerie     #Messagerie : messagerie de l'utilisateur courant
	@fenetreMessagerie #FenÃªtre : fenÃ¨tre principale de la messagerie
	#Paramétrage et crÃ©ation de l'interface
	def initialize(util)
		@gest = GestionnaireUtilisateur.new()
		@utilisateur = util
		@messagerie = util.messagerie
		@idMess=0
		#fenêtre
			@fenetreMessagerie = Window.new()
			@fenetreMessagerie.modal = true
			@fenetreMessagerie.set_title("Messagerie")
		#centrage
			@fenetreMessagerie.set_window_position(Window::POS_CENTER_ALWAYS)
			@fenetreMessagerie.set_default_size(540,300)
		#images pour les mais
			mail_ferme=Gdk::Pixbuf.new("images/mail-open.png")
			mail_ouvert=Gdk::Pixbuf.new("images/mail-close.png")
		#La boite de récéption
			# Une HBox
				hBoxPrimaire= HBox.new(false, 2)
			#la liste des messages
				listStoreMes = ListStore.new(String, String,Gdk::Pixbuf,Integer,String)
				listMes = TreeView.new(listStoreMes)
				fenetrelistStoreMes=ScrolledWindow.new()
				fenetrelistStoreMes.add(listMes)
				fenetrelistStoreMes.set_policy(POLICY_NEVER,POLICY_AUTOMATIC)
				listMes.selection.mode = SELECTION_SINGLE
				renderer = CellRendererText.new
				col = TreeViewColumn.new("ExpÃ©diteur",renderer, :text => 0)
				col.set_sort_column_id(0)
				listMes.append_column(col)
				col = TreeViewColumn.new("Titre du message", renderer, :text => 1)
				col.set_sort_column_id(1)
				listMes.append_column(col)
				renderer2 = Gtk::CellRendererPixbuf.new
				col = Gtk::TreeViewColumn.new("Statut", renderer2,:pixbuf => 2 )
				listMes.append_column(col)  
			#Ajout des éléments dans la liste des messages
				self.rafraichirListMes(listStoreMes)
			# Une VBox pour la partie droite
				vboxDroite= VBox.new(false, 5)
			# Une HBox pour la partie droite
				hBoxExp= HBox.new(true, 2)
			#expéditeur et label pour l'afficher
				expediteur=Label.new("ExpÃ©diteur :")
				entExpediteur=Entry.new()
				entExpediteur.set_editable(false)
			#label présentant le message
				enTete=Label.new("Message :")
			#corps du message
				corpsMessage= TextView.new()
				fenetreCorpsMessage=ScrolledWindow.new()
				fenetreCorpsMessage.add(corpsMessage)
				fenetreCorpsMessage.set_policy(POLICY_AUTOMATIC,POLICY_AUTOMATIC)
				corpsMessage.set_editable(false)
			# UneHBox pour les boutons et création des boutons
				maHBoxBtnRecep = HBox.new(false, 4)
				btnQuit=Button.new(Stock::QUIT)
				btnDel=Button.new("Supprimer").set_image(Gtk::Image.new(Stock::DELETE,IconSize::LARGE_TOOLBAR))
				btnAns=	Button.new("RÃ©pondre").set_image(Gtk::Image.new(Stock::GO_FORWARD,IconSize::LARGE_TOOLBAR))
			#ajout des boutons
				maHBoxBtnRecep.add(btnQuit)
				maHBoxBtnRecep.add(btnDel)
				maHBoxBtnRecep.add(btnAns)
			#ajout des widgets aux box
				hBoxPrimaire.pack_start(fenetrelistStoreMes,true,true,0)
				hBoxPrimaire.pack_start(vboxDroite,true,false,0)
				vboxDroite.pack_start(hBoxExp,false,false,0)
				hBoxExp.pack_start(expediteur,false,false,0)
				hBoxExp.pack_start(entExpediteur,true,true,0)
				vboxDroite.pack_start(enTete,false,false,0)
				vboxDroite.pack_start(fenetreCorpsMessage,true,true,0)
				vboxDroite.pack_start(maHBoxBtnRecep,false,false,0)
		
		
		#La boite d'envoi
			# Une VBox
				vboxEnv= VBox.new(false, 4)
			# Une HBox pour le Destinataire
				hBoxDest= HBox.new(false, 2)
			#Destinataire et label pour l'afficher
				destinataire=Label.new("Destinataire :")
				entDestinataire=Entry.new()
			#label présentant le message
				enTeteEnvoi=Label.new("Message :")
			#corps du message
				corpsMessageEnvoi= TextView.new()
				fenetreCorpsMessageEnvoi=ScrolledWindow.new()
				fenetreCorpsMessageEnvoi.add(corpsMessageEnvoi)
				fenetreCorpsMessageEnvoi.set_policy(POLICY_AUTOMATIC,POLICY_AUTOMATIC)
			# UneHBox pour les boutons et création des boutons
				maHBoxBtnEnvoi = HBox.new(false, 5)
				btnQuitEnvoi=Button.new(Stock::QUIT)
				btnQuitEnvoi.use_stock=(true)
				btnEnvoi=Button.new("Envoyer").set_image(Gtk::Image.new("images/stock_mail_forward.png"))
			#ajout des boutons
				maHBoxBtnEnvoi.add(btnQuitEnvoi)
				maHBoxBtnEnvoi.add(btnEnvoi)
			#ajout des widgets aux box
				vboxEnv.pack_start(hBoxDest,false,false,0)
				hBoxDest.pack_start(destinataire,false,false,0)
				hBoxDest.pack_start(entDestinataire,true,true,0)
				vboxEnv.pack_start(enTeteEnvoi,false,false,0)
				vboxEnv.pack_start(fenetreCorpsMessageEnvoi,true,true,0)
				vboxEnv.pack_start(maHBoxBtnEnvoi,false,false,0)
		
		#les onglets
			onglets = Notebook.new
			onglets.scrollable=true
			
			frameOnglet={"Boite de rÃ©ception" => hBoxPrimaire,"Envoi de messages" => vboxEnv}
			
			titreOnglet=["Boite de rÃ©ception","Envoi de messages"] 
			
			titreOnglet.each {|titre,frame|
			  frame=frameOnglet[titre]
			  ongBox=HBox.new()
			  ongBox.pack_start(Label.new(titre))
			  # Bizarre mais nécessaire
			  ongBox.show_all
			  onglets.append_page_menu(frame,ongBox,Label.new(titre))
			}
	
		#Les signaux
			#signaux de fermeture
				@fenetreMessagerie.signal_connect('destroy') {
					self.signalQuit()
				}
				btnQuit.signal_connect('clicked') {
					self.signalQuit()
				}
				btnQuitEnvoi.signal_connect('clicked') {
					self.signalQuit()
				}
			#signaux d'envoi et supréssuion de message
				btnEnvoi.signal_connect('clicked') {
					msgErr = ""
					msgConfirm = ""
					tabDestinateurs = entDestinataire.text.split(",")
					tabDestinateurs.each do |dest|
						
						utiliEnvoi = @gest.getUtilisateur(dest)
						if utiliEnvoi != nil
							
							idLibre = utiliEnvoi.messagerie.donneIdLibre()
							msg = Message.new(idLibre, @utilisateur.nom, corpsMessageEnvoi.buffer.text)
							
							utiliEnvoi.messagerie.recevoirMessage(msg)
							utiliEnvoi.enregistrer()
							msgConfirm += "Le message pour "+dest+" a bien ete envoye.\n"
						else
							msgErr += "Erreur !!! l'utilisateur "+dest+" n'existe pas.\n"
						end
					end
					entDestinataire.text = ""
					corpsMessageEnvoi.buffer.text = ""
					
					quickMessage(msgConfirm + msgErr)
					onglets.page = 0
				}
				btnDel.signal_connect('clicked') {
					message="Voulez vous vraiment supprimer \nle message de "+entExpediteur.text+" ?"
					if msgConfirmation(message)
						@messagerie.supprimerMessage(@idMess)
						self.rafraichirListMes(listStoreMes)
					end
				}
			#signal de clic dans le treeview
				listMes.signal_connect('cursor-changed'){|v|
					@idMess=v.selection.selected.get_value(3)
					entExpediteur.text=v.selection.selected.get_value(0)
					@messagerie.getMessage(@idMess).changerStatut()
					corpsMessage.buffer.text=(v.selection.selected.get_value(4))
					v.selection.selected.set_value(2,mail_ferme)
				}
			#signal du bouton repondre
				btnAns.signal_connect('clicked'){
					corpsMessageEnvoi.buffer.text = "\n-------------------------------\n"+corpsMessage.buffer.text
					entDestinataire.text = entExpediteur.text
					onglets.page = 1
				}
		#La mise en place
			@fenetreMessagerie.add(onglets)
			@fenetreMessagerie.show_all
	end
	
	#Dê§©nition du signal pour fermer la fenëµ²e
	def signalQuit()
		@utilisateur.enregistrer
		@fenetreMessagerie.destroy()
		
	end
	
	#Remplissage du listStore avec les messages de l'utilisateur
	def rafraichirListMes(list)
		list.clear()
		mail_ferme=Gdk::Pixbuf.new("images/mail-open.png")
		mail_ouvert=Gdk::Pixbuf.new("images/mail-close.png")
		@messagerie.lstMessages.each_value(){|mess|
				if @messagerie.getMessage(mess.id).statut
					image=mail_ferme
				else
					image=mail_ouvert
				end
				element = list.append()
				element[0] = mess.expediteur
				element[1] = self.couperMessage(mess.message)
				element[2] = image
				element[3] = mess.id
				element[4] = mess.message
		}
	end
	#Récupérer un échantillion d'une chaine suivi par '...'
	def couperMessage(chaine)
		return chaine[0..10]+"..."
	end
end
