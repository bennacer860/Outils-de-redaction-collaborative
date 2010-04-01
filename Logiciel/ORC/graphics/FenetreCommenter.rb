
require 'gtk2'
include Gtk
##############################################################################
# Projet L3 Groupe 2 : classe FenetreCommenter
#
#
# derniÃ¨re modification :	12/04/07, Max
# todo : 
##############################################################################

class FenetreCommenter
	
	#initialise la fenetre FenetreCommenter
	#param : partie
	def initialize(partie, utilisateur)
		Gtk.init
		@fenetreCommenter = Window.new()
		@fenetreCommenter.modal = true
		@fenetreCommenter.set_title("Ajouter un comentaire")
		@fenetreCommenter.signal_connect('destroy'){
			Gtk.main_quit
		}
		
		@vBoxContainer = VBox.new(false,3)
		
		#zone reference a un commentaire
		@hBoxRef = HBox.new(false,2)
		@vBoxContainer.add(@hBoxRef)
		@labelRef = Label.new("Faire reference a un commentaire : ")
		#liste des id et titres
		@comboBox = ComboBox.new()
		@comboBox.append_text("Ne pas referencer un commentaire")
		@comboBox.set_active(0)
		
		#liste des commentaires associÃ©s Ã  leur id
		@listeCom = Hash.new()
		
		partie.eachCommentaire do |com|
			@listeCom.store(com.numero, com)
			@comboBox.append_text(com.numero.to_s+" : "+com.texte[0..30]+"...")
		end

		#zone editable
		@frameTexte = Frame.new("Entrez ici votre commentaire")
		@zoneTexte = TextView.new().set_editable(true).set_size_request(300,200)
		@frameTexte.add(@zoneTexte)
		@vBoxContainer.add(@frameTexte)
		
		#les boutons
		#bouton annuler:
		@btnAnnuler = Button.new(Stock::CANCEL)
		#action du bouton annuler
		@btnAnnuler.signal_connect('clicked') do 
			@fenetreCommenter.destroy()
		end
		#bouton Valider:
		@btnValider = Button.new(Stock::OK)
		#action du bouton valider
		@btnValider.signal_connect('clicked') do
			actionValider(partie, utilisateur, @comboBox, @zoneTexte, @listeCom)
		end
	
		@buttonBox = HButtonBox.new()

		@buttonBox.add(@btnAnnuler)
		@buttonBox.add(@btnValider)
		@vBoxContainer.add(@buttonBox)
		
		@hBoxRef.add(@labelRef)
		@hBoxRef.add(@comboBox)
		@fenetreCommenter.add(@vBoxContainer)
		@fenetreCommenter.show_all()
		Gtk.main
	end

	def actionValider(partie, utilisateur, comboBox, texte, listeCom)
		num = 1
		#recuperation du numero du dernier commentaire
		if(partie.nbCommentaires!=0)
			partie.eachCommentaire do |com|
				num = com.numero+1 if com.numero >= num
			end
		end
		#si pas de reference => ajouter le commentaire Ã  la liste des comm de la partie
		com = Commentaire.creer(num, texte.buffer.text(), utilisateur, partie)

		if(comboBox.active()==0)
			#reference à 0 (pas de référence)
			com.ajouterRef(0)
		else
			#référence prend la valeur du commentaire de référence
			com.ajouterRef(listeCom[comboBox.active()].numero)
			#ajouter l'id du  nouveau commentaire dans la table de referents du commentaire superieur
			listeCom[comboBox.active()].ajouterReferent(com.numero)
		end
		partie.ajouterCommentaire(com)

		# enregistrer si utilisateur est visiteur ou admin
		if utilisateur.estVisiteur?() or utilisateur.estAdministrateur?()
			partie.enregistrer()
		end
		@fenetreCommenter.destroy()
	end

end






