# -*- coding: utf-8 -*-


require 'gtk2'

class FenetreEditerParagraphe
  
  def initialize(partie)
    Gtk.init
    
    @fenetre = Gtk::Window.new()
    @fenetre.title = "Editer la partie"
    @fenetre.set_default_size(500,450)
    @fenetre.window_position = Gtk::Window::POS_CENTER
    @fenetre.signal_connect('destroy') do
      Gtk.main_quit()
    end
    
    @boiteFenetre = Gtk::VBox.new()
    
    # Titre
    @boiteTitre = Gtk::HBox.new()
    
    @labelTitre = Gtk::Label.new("Titre : ")
    @saisieTitre = Gtk::Entry.new()
    @saisieTitre.text = partie.titre
    
    @boiteTitre.pack_start(@labelTitre, false, false, 0)
    @boiteTitre.pack_start(@saisieTitre, true, true, 0)
    
    # Label Contenu
    @labelContenu = Gtk::Label.new("Contenu :")
    
    # Saisie Contenu
    @edition = Gtk::VBox.new()
    
    #initialisation du texte
			texte = partie.contenu
			
		# parser RestructureText
			@parserRst2Html = ParseurRsT2Html.new()
			@parserHtml2RsT = ParseurHtml2RsT.new()
			
		# textview
			textLocal=Gtk::TextView.new()
			textLocal.wrap_mode = Gtk::TextTag::WRAP_CHAR
			textLocal.buffer.text=@parserHtml2RsT.html2RsT(texte)
		# Crꢴions des ꭩments de l'interface
			textLabel=Label.new
			fenetreTextView=Gtk::ScrolledWindow.new()
                        fenetreTextView.add(textLocal)
                        fenetreTextView.set_policy(Gtk::POLICY_AUTOMATIC,Gtk::POLICY_AUTOMATIC)
			btnPrev=Gtk::Button.new("Previsualiser").set_image(Gtk::Image.new(Gtk::Stock::FIND,Gtk::IconSize::LARGE_TOOLBAR))
			boiteVerticale=Gtk::VBox.new(false,3)
			textEtLabel=Gtk::HBox.new(2)
			hBoxBtn=Gtk::HBox.new(2)
			barreMenu=Gtk::Toolbar.new()
		# crꢴion des boutons de la toolbar
			btnGras = Gtk::ToolButton.new(Gtk::Stock::BOLD)
			btnGras.label = "Gras"
			btnGras.signal_connect('clicked') {
			#On rꤵp鳥 la selection
				tabIter=textLocal.buffer.selection_bounds
			#si la sꭩction n'est pas vide
				if (tabIter != nil)
					# ꤲire les balises autour de la sꭩction
					selection=tabIter[0].get_text(tabIter[1])
					textLocal.buffer.delete_selection(true, true)
					textLocal.insert_at_cursor(@parserRst2Html.baliseGras()+selection+@parserRst2Html.baliseGras())
				else
					# si la sꭩction est vide
					# ꤲire les balises et positionner le curseur entre elles
					textLocal.insert_at_cursor(@parserRst2Html.baliseGras()+" "+@parserRst2Html.baliseGras())
					textLocal.move_cursor(Gtk::MOVEMENT_VISUAL_POSITIONS, -3,false)
				end
			}
		
			btnItalique = Gtk::ToolButton.new(Gtk::Stock::ITALIC)
			btnItalique.label = "Italique"
			btnItalique.signal_connect('clicked') {
				#On rꤵp鳥 la selection
				tabIter=textLocal.buffer.selection_bounds
				#si la sꭩction n'est pas vide
				if (tabIter != nil)
					# ꤲire les balises autour de la sꭩction
					selection=tabIter[0].get_text(tabIter[1])
					textLocal.buffer.delete_selection(true, true)
					textLocal.insert_at_cursor(@parserRst2Html.baliseItalique()+selection+@parserRst2Html.baliseItalique())
				else
					# si la sꭩction est vide
					# ꤲire les balises et positionner le curseur entre elles
					textLocal.insert_at_cursor(@parserRst2Html.baliseItalique()+" "+@parserRst2Html.baliseItalique())
					textLocal.move_cursor(Gtk::MOVEMENT_VISUAL_POSITIONS, -3,false)
				end
			}
			
			btnSouligne = Gtk::ToolButton.new(Gtk::Stock::UNDERLINE)
			btnSouligne.label = "Souligne"
			btnSouligne.signal_connect('clicked') {
				#On rꤵp鳥 la selection
				tabIter=textLocal.buffer.selection_bounds
				#si la sꭩction n'est pas vide
				if (tabIter != nil)
					# ꤲire les balises autour de la sꭩction
					selection=tabIter[0].get_text(tabIter[1])
					textLocal.buffer.delete_selection(true, true)
					textLocal.insert_at_cursor(@parserRst2Html.baliseSouligne()+selection+@parserRst2Html.baliseSouligne())
				else
					# si la sꭩction est vide
					# ꤲire les balises et positionner le curseur entre elles
					textLocal.insert_at_cursor(@parserRst2Html.baliseSouligne()+" "+@parserRst2Html.baliseSouligne())
					textLocal.move_cursor(Gtk::MOVEMENT_VISUAL_POSITIONS, -3,false)
				end
			}
			
			btnBarre = ToolButton.new(Gtk::Stock::STRIKETHROUGH)
			btnBarre.label = "Barre"
			btnBarre.signal_connect('clicked') {
				#On rꤵp鳥 la selection
				tabIter=textLocal.buffer.selection_bounds
				#si la sꭩction n'est pas vide
				if (tabIter != nil)
					# ꤲire les balises autour de la sꭩction
					selection=tabIter[0].get_text(tabIter[1])
					textLocal.buffer.delete_selection(true, true)
					textLocal.insert_at_cursor(@parserRst2Html.baliseBarre()+selection+@parserRst2Html.baliseBarre())
				else
					# si la sꭩction est vide
					# ꤲire les balises et positionner le curseur entre elles
					textLocal.insert_at_cursor(@parserRst2Html.baliseBarre()+" "+@parserRst2Html.baliseBarre())
					textLocal.move_cursor(Gtk::MOVEMENT_VISUAL_POSITIONS, -3,false)
					# ꤲire les balises et positionner le curseur entre elles
					textLocal.insert_at_cursor(@parserRst2Html.baliseBarre()+" "+@parserRst2Html.baliseBarre())
					textLocal.move_cursor(Gtk::MOVEMENT_VISUAL_POSITIONS, -3,false)
				end
			}
			btnPlusGros = ToolButton.new(Gtk::Stock::ZOOM_IN)
			btnPlusGros.label = "Agrandi"
			btnPlusGros.signal_connect('clicked') {
				#On rꤵp鳥 la selection
				tabIter=textLocal.buffer.selection_bounds
				#si la sꭩction n'est pas vide
				if (tabIter != nil)
					# ꤲire les balises autour de la sꭩction
					selection=tabIter[0].get_text(tabIter[1])
					textLocal.buffer.delete_selection(true, true)
					textLocal.insert_at_cursor(@parserRst2Html.balisePlusGros()+selection+@parserRst2Html.balisePlusGros())
				else
					# si la sꭩction est vide
					# ꤲire les balises et positionner le curseur entre elles
					textLocal.insert_at_cursor(@parserRst2Html.balisePlusGros()+" "+@parserRst2Html.balisePlusGros())
					textLocal.move_cursor(MOVEMENT_VISUAL_POSITIONS, -3,false)
				end
			}
			btnPlusPetit = ToolButton.new(Gtk::Stock::ZOOM_OUT)
			btnPlusPetit.label = "Retreci"
			btnPlusPetit.signal_connect('clicked') {
				#On rꤵp鳥 la selection
				tabIter=textLocal.buffer.selection_bounds
				#si la sꭩction n'est pas vide
				if (tabIter != nil)
					# ꤲire les balises autour de la sꭩction
					selection=tabIter[0].get_text(tabIter[1])
					textLocal.buffer.delete_selection(true, true)
					textLocal.insert_at_cursor(@parserRst2Html.balisePlusPetit()+selection+@parserRst2Html.balisePlusPetit())
				else
					# si la sꭩction est vide
					# ꤲire les balises et positionner le curseur entre elles
					textLocal.insert_at_cursor(@parserRst2Html.balisePlusPetit()+" "+@parserRst2Html.balisePlusPetit())
					textLocal.move_cursor(Gtk::MOVEMENT_VISUAL_POSITIONS, -3,false)
				end
			}
			btnTitre1 = ToolButton.new(Gtk::Stock::ZOOM_OUT)
			btnTitre1.label = "Titre1"
			btnTitre1.signal_connect('clicked') {
				#On rꤵp鳥 la selection
				tabIter=textLocal.buffer.selection_bounds
				#si la sꭩction n'est pas vide
				if (tabIter != nil)
					# ꤲire les balises autour de la sꭩction
					selection=tabIter[0].get_text(tabIter[1])
					textLocal.buffer.delete_selection(true, true)
					textLocal.insert_at_cursor(@parserRst2Html.baliseTitre1()+selection+@parserRst2Html.baliseTitre1())
				else
					# si la sꭩction est vide
					# ꤲire les balises et positionner le curseur entre elles
					textLocal.insert_at_cursor(@parserRst2Html.baliseTitre1()+" "+@parserRst2Html.baliseTitre1())
					textLocal.move_cursor(Gtk::MOVEMENT_VISUAL_POSITIONS, -3,false)
				end
			}
			btnTitre2 = ToolButton.new(Gtk::Stock::ZOOM_OUT)
			btnTitre2.label = "Titre2"
			btnTitre2.signal_connect('clicked') {
				#On rꤵp鳥 la selection
				tabIter=textLocal.buffer.selection_bounds
				#si la sꭩction n'est pas vide
				if (tabIter != nil)
					# ꤲire les balises autour de la sꭩction
					selection=tabIter[0].get_text(tabIter[1])
					textLocal.buffer.delete_selection(true, true)
					textLocal.insert_at_cursor(@parserRst2Html.baliseTitre2()+selection+@parserRst2Html.baliseTitre2())
				else
					# si la sꭩction est vide
					# ꤲire les balises et positionner le curseur entre elles
					textLocal.insert_at_cursor(@parserRst2Html.baliseTitre2()+" "+@parserRst2Html.baliseTitre2())
					textLocal.move_cursor(Gtk::MOVEMENT_VISUAL_POSITIONS, -3,false)
				end
			}
		
		# ajout des boutons dans la barre de menus
		barreMenu.add(btnGras)
		barreMenu.add(btnItalique)
		barreMenu.add(btnSouligne)
		barreMenu.add(btnBarre)
		barreMenu.add(btnPlusGros)
		barreMenu.add(btnPlusPetit)
		barreMenu.add(btnTitre1)
		barreMenu.add(btnTitre2)
		# ajout des objets
		@edition.pack_start(barreMenu,false,false,0)
		@edition.pack_start(textEtLabel,true,true,0)
		@edition.pack_start(hBoxBtn,false,false,0)
		hBoxBtn.pack_start(btnPrev,false,true,0)
		textEtLabel.pack_start(fenetreTextView,false,true,0)
		textEtLabel.pack_start(textLabel,false,false,0)
			
		btnPrev.signal_connect('clicked') {
			texteHtml = @parserRst2Html.rsT2Html(textLocal.buffer.text)
			textLabel.set_markup(texteHtml)
		}
    
    # Boutons
    @boiteBoutons = Gtk::HBox.new()

    @boutonAnnuler = Gtk::Button.new(Gtk::Stock::CANCEL)
    @boutonValider = Gtk::Button.new(Gtk::Stock::OK)

    @boiteBoutons.pack_start(@boutonAnnuler, true, true, 0)
    @boiteBoutons.pack_start(@boutonValider, true, true, 0)

    # signaux des boutons
    
    @boutonAnnuler.signal_connect('clicked') do
      @fenetre.destroy()
    end
    
    @boutonValider.signal_connect('clicked') do
	texteHtml = @parserRst2Html.rsT2Html(textLocal.buffer.text)
	partie.titre = @saisieTitre.text
	partie.contenu = texteHtml
	@fenetre.destroy()
    end
    
    # Ajout de toutes les boites a la fenetre
    @boiteFenetre.pack_start(@boiteTitre, false , false, 0)
    @boiteFenetre.pack_start(@labelContenu, false , false, 0)
    @boiteFenetre.pack_start(@edition, true , true, 3)
    @boiteFenetre.pack_start(@boiteBoutons, false , false, 0)
    
    @fenetre.add(@boiteFenetre)
    @fenetre.show_all()
    
    Gtk.main
  end
  
end
