# -*- coding: utf-8 -*-

require 'gtk2'
include Gtk

##############################################################################
# Projet L3 Groupe 2 :
#
# ...
#
# dernière modification :	04/04/07, beber
# todo : Signal Bouton Apply
##############################################################################

class FenetreEditerTexte
	
	@fenetreText		# Fenetre : fenetre principale de la messagerie
	@parserRst2Html		# ParseurRsT2Html
	@parserHtml2RsT		#ParseurHtml2RsT 
	@texte		#Résultat de l'édition : String
	attr_reader :texte

	def initialize(texte)
		#initialisation du texte
			@texte=nil
		# fenetre
			@fenetreText = Window.new()
			@fenetreText.set_title("Editeur")
		# parser RestructureText
			@parserRst2Html = ParseurRsT2Html.new()
			@parserHtml2RsT = ParseurHtml2RsT.new()
		# centrage
			@fenetreText.set_window_position(Window::POS_CENTER_ALWAYS)
			@fenetreText.modal = true
			@fenetreText.set_default_size(500,300)
		# textview
			textLocal=TextView.new()
			textLocal.buffer.text=@parserHtml2RsT.html2RsT(texte)
		# Créations des éléments de l'interface
			textLabel=Label.new
			fenetreTextView=ScrolledWindow.new()
                        fenetreTextView.add(textLocal)
                        fenetreTextView.set_policy(POLICY_AUTOMATIC,POLICY_AUTOMATIC)
			btnApply=Button.new(Stock::APPLY)
			btnPrev=Button.new("Prévisualiser").set_image(Gtk::Image.new(Stock::FIND,IconSize::LARGE_TOOLBAR))
			btnCancel=Button.new(Stock::CANCEL)
			boiteVerticale=VBox.new(false,3)
			textEtLabel=HBox.new(2)
			hBoxBtn=HBox.new(2)
			barreMenu=Toolbar.new()
		# création des boutons de la toolbar
			btnGras = ToolButton.new(Stock::BOLD)
			btnGras.label = "Gras"
			btnGras.signal_connect('clicked') {
			#On récupère la selection
				tabIter=textLocal.buffer.selection_bounds
			#si la séléction n'est pas vide
				if (tabIter != nil)
					# écrire les balises autour de la séléction
					selection=tabIter[0].get_text(tabIter[1])
					textLocal.buffer.delete_selection(true, true)
					textLocal.insert_at_cursor(@parserRst2Html.baliseGras()+selection+@parserRst2Html.baliseGras())
				else
					# si la séléction est vide
					# écrire les balises et positionner le curseur entre elles
					textLocal.insert_at_cursor(@parserRst2Html.baliseGras()+" "+@parserRst2Html.baliseGras())
					textLocal.move_cursor(MOVEMENT_VISUAL_POSITIONS, -3,false)
				end
			}
		
			btnItalique = ToolButton.new(Stock::ITALIC)
			btnItalique.label = "Italique"
			btnItalique.signal_connect('clicked') {
				#On récupère la selection
				tabIter=textLocal.buffer.selection_bounds
				#si la séléction n'est pas vide
				if (tabIter != nil)
					# écrire les balises autour de la séléction
					selection=tabIter[0].get_text(tabIter[1])
					textLocal.buffer.delete_selection(true, true)
					textLocal.insert_at_cursor(@parserRst2Html.baliseItalique()+selection+@parserRst2Html.baliseItalique())
				else
					# si la séléction est vide
					# écrire les balises et positionner le curseur entre elles
					textLocal.insert_at_cursor(@parserRst2Html.baliseItalique()+" "+@parserRst2Html.baliseItalique())
					textLocal.move_cursor(MOVEMENT_VISUAL_POSITIONS, -3,false)
				end
			}
			
			btnSouligne = ToolButton.new(Stock::UNDERLINE)
			btnSouligne.label = "Souligné"
			btnSouligne.signal_connect('clicked') {
				#On récupère la selection
				tabIter=textLocal.buffer.selection_bounds
				#si la séléction n'est pas vide
				if (tabIter != nil)
					# écrire les balises autour de la séléction
					selection=tabIter[0].get_text(tabIter[1])
					textLocal.buffer.delete_selection(true, true)
					textLocal.insert_at_cursor(@parserRst2Html.baliseSouligne()+selection+@parserRst2Html.baliseSouligne())
				else
					# si la séléction est vide
					# écrire les balises et positionner le curseur entre elles
					textLocal.insert_at_cursor(@parserRst2Html.baliseSouligne()+" "+@parserRst2Html.baliseSouligne())
					textLocal.move_cursor(MOVEMENT_VISUAL_POSITIONS, -3,false)
				end
			}
			
			btnBarre = ToolButton.new(Stock::STRIKETHROUGH)
			btnBarre.label = "Barré"
			btnBarre.signal_connect('clicked') {
				#On récupère la selection
				tabIter=textLocal.buffer.selection_bounds
				#si la séléction n'est pas vide
				if (tabIter != nil)
					# écrire les balises autour de la séléction
					selection=tabIter[0].get_text(tabIter[1])
					textLocal.buffer.delete_selection(true, true)
					textLocal.insert_at_cursor(@parserRst2Html.baliseBarre()+selection+@parserRst2Html.baliseBarre())
				else
					# si la séléction est vide
					# écrire les balises et positionner le curseur entre elles
					textLocal.insert_at_cursor(@parserRst2Html.baliseBarre()+" "+@parserRst2Html.baliseBarre())
					textLocal.move_cursor(MOVEMENT_VISUAL_POSITIONS, -3,false)
					# écrire les balises et positionner le curseur entre elles
					textLocal.insert_at_cursor(@parserRst2Html.baliseBarre()+" "+@parserRst2Html.baliseBarre())
					textLocal.move_cursor(MOVEMENT_VISUAL_POSITIONS, -3,false)
				end
			}
			btnPlusGros = ToolButton.new(Stock::ZOOM_IN)
			btnPlusGros.label = "Agrandi"
			btnPlusGros.signal_connect('clicked') {
				#On récupère la selection
				tabIter=textLocal.buffer.selection_bounds
				#si la séléction n'est pas vide
				if (tabIter != nil)
					# écrire les balises autour de la séléction
					selection=tabIter[0].get_text(tabIter[1])
					textLocal.buffer.delete_selection(true, true)
					textLocal.insert_at_cursor(@parserRst2Html.balisePlusGros()+selection+@parserRst2Html.balisePlusGros())
				else
					# si la séléction est vide
					# écrire les balises et positionner le curseur entre elles
					textLocal.insert_at_cursor(@parserRst2Html.balisePlusGros()+" "+@parserRst2Html.balisePlusGros())
					textLocal.move_cursor(MOVEMENT_VISUAL_POSITIONS, -3,false)
				end
			}
			btnPlusPetit = ToolButton.new(Stock::ZOOM_OUT)
			btnPlusPetit.label = "Rétréci"
			btnPlusPetit.signal_connect('clicked') {
				#On récupère la selection
				tabIter=textLocal.buffer.selection_bounds
				#si la séléction n'est pas vide
				if (tabIter != nil)
					# écrire les balises autour de la séléction
					selection=tabIter[0].get_text(tabIter[1])
					textLocal.buffer.delete_selection(true, true)
					textLocal.insert_at_cursor(@parserRst2Html.balisePlusPetit()+selection+@parserRst2Html.balisePlusPetit())
				else
					# si la séléction est vide
					# écrire les balises et positionner le curseur entre elles
					textLocal.insert_at_cursor(@parserRst2Html.balisePlusPetit()+" "+@parserRst2Html.balisePlusPetit())
					textLocal.move_cursor(MOVEMENT_VISUAL_POSITIONS, -3,false)
				end
			}
		
		# ajout des boutons dans la barre de menus
		barreMenu.add(btnGras)
		barreMenu.add(btnItalique)
		barreMenu.add(btnSouligne)
		barreMenu.add(btnBarre)
		barreMenu.add(btnPlusGros)
		barreMenu.add(btnPlusPetit)
		# ajout des objets
		boiteVerticale.pack_start(barreMenu,false,false,0)
		boiteVerticale.pack_start(textEtLabel,true,true,0)
		boiteVerticale.pack_start(hBoxBtn,false,false,0)
		hBoxBtn.pack_start(btnPrev,false,true,0)
		hBoxBtn.pack_start(btnCancel,false,true,0)
		hBoxBtn.pack_start(btnApply,false,true,0)
		textEtLabel.pack_start(fenetreTextView,false,true,0)
		textEtLabel.pack_start(textLabel,false,false,0)
		@fenetreText.add(boiteVerticale)
			
		@fenetreText.show_all
		btnPrev.signal_connect('clicked') {
			texteHtml = @parserRst2Html.rsT2Html(textLocal.buffer.text)
			textLabel.set_markup(texteHtml)
		}
		btnCancel.signal_connect('clicked') {
			@fenetreText.destroy()
		}
		btnApply.signal_connect('clicked') {
			texteHtml = @parserRst2Html.rsT2Html(textLocal.buffer.text)
			@texte=texteHtml
			@fenetreText.destroy()
		}
		@fenetreText.signal_connect('destroy') {
			Gtk.main_quit
		}
	end
	
end
