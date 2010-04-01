
require 'gtk2'
include Gtk

##############################################################################
# Projet L3 Groupe 2 : classe FenetreOuvrirDoc
#
#
# dernière modification :	29/03/06, Max
# todo : 
##############################################################################

class FenetreOuvrirDoc

	@idDocument
	attr_reader:idDocument

	#initialiser la fenetre FenetreOuvrirDoc
	#param : utilisateur
	def initialize(utilisateur)
	Gtk.init
		
	@fenetreOuvrirDoc = Window.new()
	@fenetreOuvrirDoc.set_title("Selection du Document")
	@fenetreOuvrirDoc.modal = true
	@fenetreOuvrirDoc.window_position= Gtk::Window::POS_CENTER
	@fenetreOuvrirDoc.signal_connect('destroy') do
		Gtk.main_quit()
	end
	
	#taille de la fenetre
	@fenetreOuvrirDoc.set_default_size(500,300)

	frame = Frame.new()
	#VBox Container
	vBoxContainer = VBox.new(false, 3)

	docs = recupererDocs(utilisateur)
	
	#liste des documents : nom de l'auteur, nom du document
	listeDocuments = ListStore.new(String, String)

	docs.each do |titre, numEtAuteur|
		numEtAuteur.each do |num, auteur|
			element = listeDocuments.append()
			element[0] = auteur
			element[1] = titre
		end
	end

	#zone de recherche:
	hBoxHaut = HBox.new(false, 2)
	#label recherche:
	labelRecherche = Label.new("Rechercher :")
	#champ de recherche:
	champRecherche = Entry.new()
	#ajout de l'outil de completion de la recherche:
	completion = EntryCompletion.new()
	completion.model = listeDocuments
	completion.text_column = 1
	champRecherche.completion = completion
	

	hBoxHaut.add(labelRecherche)
	hBoxHaut.add(champRecherche)

	# Un TreeView pour visualiser les données de la liste
	viewListe = TreeView.new(listeDocuments)
	viewListe.selection.mode = SELECTION_SINGLE
	
	#colonne Auteur
	#mode affichage
	renderer = CellRendererText.new
	#le rendu doit être éditable
	renderer.set_editable(true)
	# Ajout d'uhe colonne utilisant ce rendu
        col = TreeViewColumn.new("Auteur", renderer, :text => 0)
	#permet de trier par auteur
	col.set_sort_column_id(0)
	col.sizing = TreeViewColumn::FIXED
	col.fixed_width = 150
	viewListe.append_column(col)
	
	#colonne Titre
	#mode d'affichage
	renderer = CellRendererText.new
	# On utilise Pango pour obtenir le gras
        renderer.weight = Pango::FontDescription::WEIGHT_BOLD
        # Ajout d'une colonne utilisant ce rendu
        col = TreeViewColumn.new("Titre", renderer, :text => 1)
	#permet de trier par titre
	col.set_sort_column_id(1)
	col.sizing = TreeViewColumn::FIXED
	col.fixed_width = 250
	viewListe.append_column(col)
	
	#on autorise la recherche sur la seconde colonne
	viewListe.set_search_column(1)


	#zone des boutons
	hBoxBas = HBox.new(false,2)
	#conteneur des boutons
	buttonBox = HButtonBox.new()
	buttonBox.set_border_width(5)
	#bouton annuler:
	btnAnnuler = Button.new(Stock::CANCEL)
	#action du bouton Annuler
	btnAnnuler.signal_connect('clicked') do 
		@fenetreOuvrirDoc.destroy()
	end
	buttonBox.add(btnAnnuler)


	#bouton OK
	btnOk = Button.new(Stock::OPEN)
	buttonBox.add(btnOk)
	btnOk.signal_connect('clicked') do
		actionOK(viewListe, champRecherche, docs)
	end
	hBoxBas.add(buttonBox)
	
	#vBoxContainer.add(selection)
	vBoxContainer.add(hBoxHaut)
	#scrollbar pour le treeview
	scrollwindow = ScrolledWindow.new(nil,nil)
	#on adapte la taille de cette zone en fonction de la taille de la fenetre
	scrollwindow.set_size_request(@fenetreOuvrirDoc.size()[0], @fenetreOuvrirDoc.size()[1])
	scrollwindow.resize_mode=(RESIZE_IMMEDIATE)#marche pôôô !devrait resizer en fonction de la fenetre!!#####################
	vBoxContainer.add(scrollwindow)
        scrollwindow.set_policy(Gtk::POLICY_NEVER, Gtk::POLICY_AUTOMATIC)
	scrollwindow.add(viewListe)
	vBoxContainer.add(hBoxBas)
	frame.add(vBoxContainer)
	@fenetreOuvrirDoc.add(frame)
	@fenetreOuvrirDoc.show_all()
	
	Gtk.main
	end #fin de l'initialize


	#definition de l'action du bouton OK
	def actionOK(viewListe, champRecherche,  docs)
		selection = viewListe.selection()
		#si l'user a selectionne un doc dans le treeview
		if iter=selection.selected
			titre = iter[1]
			num = docs[titre].keys
			@idDocument = num
			@fenetreOuvrirDoc.destroy()
		#sinon, s'il a selectionne un doc via le champ de recherche
		elsif titre = champRecherche.text()
			#si le titre entré ne figure pas dans la table de hash (dcs)
			if(!docs.has_key?(titre))
				champRecherche.text=""
				quickMessage("Ce document n'existe pas.")
			else
				num = docs[titre].keys
				@idDocument = num
				@fenetreOuvrirDoc.destroy()
			end
		else
			#si aucun document selectionné : message d'alerte
			quickMessage("Aucun document selectionne.")
		end
	end#fin actionOK

	#recuperer les titres, numero et auteur de chaque document accessibles par l'utilisateur courant
	#param  : utilisateur
	def recupererDocs(utilisateur)
		docs = Hash.new()
		utilisateur.donnerDocumentsAccessibles().each do|document|
			if  document.auteur != nil
				docs.store(document.titre, document.numero => document.auteur.nom)
			else
				docs.store(document.titre, document.numero => "")
			end
		end
		return docs
	end#fin recupererDoc
	
end #fin de la classe

#~ FenetreOuvrirDoc.new(Utilisateur.creerVisiteur())
