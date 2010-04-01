# -*- coding: utf-8 -*-

require 'gtk2'

# On inclu le module Gtk, cela évite de préfixer les classes du peu élégant Gtk::
include Gtk

class FenetreAuteur
	
	@utilisateurCourant #utilisateur courant
	@gestionnaireUtilisateur #gestionnaireUtilisateur
        @utilisateurs #tableau avec tout les utilisateur
        @doc #on utilise cette VI pour ajouter un utilisateur dans la liste des contibuteur d'un document

#methode d'instance qui permet de remplir une Combobox avec les document propres de l'auteur courant
def remplirComboBox(utilisateur)
	listeDocumentAuteur=utilisateur.donnerDocumentsCrees()
	#table de hashage pour retenir l'id de chaque doc
	@idTitre=Hash.new
	listeDocumentAuteur.each{|doc|
		#on insere le numero et le titre du chaque document dans la table de hashage
		@idTitre[doc.titre] = doc.numero
	       @combo.append_text(doc.titre)
	}
       
end


#methode d'instance qui permet de remplir une listeStore passe en parametre avec tous es utilisateur possible sauf les contibuteur du document sur lequel on travail  
  def remplirListeSource(liste,document)
	   #liste des noms des contributeur
	   listecontributeur=Array.new()
	   document.listeContributeurs.each do |util|
			nom=util.nom
			listecontributeur.push(nom)
		end
	   #on charge les differents attributs de chaque utilisateur
	@utilisateurs.each do |nom|
		if nom != @utilisateurCourant.nom
			utilisateur=Utilisateur.charger(nom)
			#si il existe deja sur la liste des contibuteur du document ,il ne faut pas l afficher
			if( ! listecontributeur.include?(utilisateur.nom))
			 # ajouter un élément à la source
			     element = liste.append()
			    element[0] = utilisateur.nom ;
			    element[1] = utilisateur.eMail;
			    element[2] = utilisateur.statut
		    end
		end
	end
   end

#methode d'instance qui permet de remplir une listeStore passe en parametre avec tous les contibuteur du document sur lequel on travail  
def remplirListeDestin(liste,document)
		#liste des noms des contributeur
		listecontributeur=Array.new()
		document.listeContributeurs.each do |util|
			nom=util.nom
			listecontributeur.push(nom)
		end
	
		#on charge la liste des contributeur d'un document
			utilisateurs=document.listeContributeurs()
		utilisateurs.each do |utilisateur|
			 # ajouter un élément à la source
			
			    element = liste.append()
			    element[0] = utilisateur.nom ;
			    element[1] = utilisateur.eMail;
			    element[2] = utilisateur.statut

		end
end

#on vide les liste
def viderListe(liste)
	liste.clear
end

	
 def initialize(utilisateur,doc)
		#variable d'instance
		@doc=utilisateur.donnerDocumentsCrees().first()
		@utilisateurCourant = utilisateur
		@gestionnaireUtilisateur = GestionnaireUtilisateur.new()
		#on charge tous les utilisateur dans le tableau  du gestionnaireUtilisateur
		@gestionnaireUtilisateur.chargerUtilisateurs()
		@utilisateurs = @gestionnaireUtilisateur.donnerContributeurs()
		#~ @doc
		@docCourant = doc
		Gtk.init

		monApplication = Window.new()
		monApplication.set_title("Gestion des documents")


		# L'application est toujours centree
		monApplication.set_window_position(Window::POS_CENTER_ALWAYS)
		monApplication.modal =true
		monApplication.set_default_size(800,330)
		monApplication.border_width=10



		# Une VBox pour mettre les composants de la fenetre dedans
		maVBoxAppli= VBox.new(false, 5)


		# -------------------------------------------------------------------
		#  les échanges entre 2 listes
		# -------------------------------------------------------------------
		  maVBoxF5=VBox.new(false,5)
		  
		  
		  #Selection Document--------------------------------------
		  boiteSlelectionDoc=HBox.new(false,5)
		 #label
		  boiteSlelectionDoc.pack_start(Label.new("Document : "),false,false,0)
		  boiteSlelectionDoc.pack_start(@combo=ComboBox.new(true),true,true,0)
		  #on ajoute des ligne de text    
		  remplirComboBox(@utilisateurCourant)
		  
		   #visibilite---------------------------------------------------------------------
			visibilite = Gtk::HBox.new(false, 6)
			visibilite.pack_start(Label.new('Visibilite : '), false,false,0)
			public = Gtk::RadioButton.new('Publique')
			visibilite.pack_start(public, false,false,0)
			prive = Gtk::RadioButton.new(public, 'Prive')
			visibilite.pack_start(prive, false,false,0)
		    #mettre le statut du document par default	
		    if(@doc.visibilitePublique == false)
			prive.set_active(true)
		    end
			
		  # Supprimer le document
			btnSupprimerDoc = Gtk::Button.new(Gtk::Stock::DELETE)
			btnSupprimerDoc.label = "Supprimer ce document"
			btnSupprimerDoc.signal_connect('clicked') do
				if @doc != nil
					if @docCourant == nil || @docCourant.numero != @doc.numero 
						GestionnaireDocument.supprimerDocument(@doc.numero)
						quickMessage("Le document a ete supprime")
						remplirComboBox(@utilisateurCourant)
						@doc = nil
						@combo.show_all
					else
						quickMessage("Ce document est actuellement utilise, pour le supprimer veuillez le fermer.")
					end
				end
			end
			
			visibilite.pack_start(btnSupprimerDoc, false,false,0)


		  # UneHBox pour  le treeView
		  maHBoxF5 = HBox.new(false, 5)
		  #une HBox pour les bouton
		  maHBox=HBox.new(false,5)
		 
		# Une structure de liste pour stocker les données
		  sourceStoreF5 = ListStore.new(String, String, String)
		  destinStoreF5 = ListStore.new(String, String, String)

		
		# un TreeView pour visualiser les données de la liste
		  sourceListeF5 = TreeView.new(sourceStoreF5)
		  destinListeF5 = TreeView.new(destinStoreF5)
		    sourceListeF5.selection.mode = SELECTION_MULTIPLE
		    destinListeF5.selection.mode = SELECTION_SINGLE
		    # Les 'renderer' permettent de préciser comment afficher les données
		      renderer = CellRendererText.new
		      renderer.foreground = "red"
		      # On utilise Pango pour obtenir le gras
		      renderer.weight = Pango::FontDescription::WEIGHT_BOLD
		      # Ajout d'une colonne utilisant ce rendu dans les deux listes
			# la liste source
			# Ajout d'uhe colonne identifiant
			cols1 = TreeViewColumn.new("Identifiant", renderer, :text => 0)
			cols1.set_sort_column_id(0)
			sourceListeF5.append_column(cols1)
			# Ajout d'uhe colonne email
			cols2 = TreeViewColumn.new("Email", renderer, :text => 1)
			cols2.set_sort_column_id(1)
			sourceListeF5.append_column(cols2)
			 # Ajout d'une colonne statut
			cols3 = TreeViewColumn.new("Statut", renderer, :text =>2)
			cols3.set_sort_column_id(2)
			sourceListeF5.append_column(cols3)
			
			
		     
			# la liste destination
			# Ajout d'uhe colonne identifiant	
			cold1 = TreeViewColumn.new("Identifiant", renderer, :text => 0)
			cold1.set_sort_column_id(0)
			destinListeF5.append_column(cold1)
			# Ajout d'uhe colonne Email
			cold2 = TreeViewColumn.new("Email", renderer, :text => 1)
			cold2.set_sort_column_id(1)
			destinListeF5.append_column(cold2)
			# Ajout d'uhe colonne Statut	
			cold3 = TreeViewColumn.new("Statut", renderer, :text => 2)
			cold3.set_sort_column_id(2)
			destinListeF5.append_column(cold3)

		      
		     
		      
		  
		  maHBoxF5.add(sourceListeF5)
		  maHBoxF5.add(autreVBoxF5=Toolbar.new)
		 autreVBoxF5.orientation=Toolbar::ORIENTATION_VERTICAL

		 #boutons de la treeview
		  btn1F5=ToolButton.new(Gtk::Stock::GO_FORWARD)
		  btn1F5.label=""
		  btn2F5=ToolButton.new(Gtk::Stock::GO_BACK)
		    btn2F5.label=""
		  btn3F5=ToolButton.new(Gtk::Stock::GOTO_LAST)
		    btn3F5.label=""
		  btn4F5=ToolButton.new(Gtk::Stock::GOTO_FIRST)
		  btn4F5.label=""
		 
		  autreVBoxF5.add(btn1F5)
		  autreVBoxF5.add(btn3F5)
		   autreVBoxF5.add(btn2F5)
		  autreVBoxF5.add(btn4F5)
		  
		  #bouton de validation et d'annulation
		  btnValider=Button.new(Gtk::Stock::APPLY)
		  btnAnnuler=Button.new(Gtk::Stock::CLOSE)
		  maHBox.add(btnValider)
		  maHBox.add(btnAnnuler)
		  
		  
		  
		  
		  

		  maHBoxF5.pack_start(destinListeF5)
		 maVBoxF5.pack_start(boiteSlelectionDoc,false,false,0)
		 maVBoxF5.pack_start(visibilite,false,false,0)
		  maVBoxF5.pack_start(maHBoxF5,true,true,0) 
		 maVBoxF5.pack_start(maHBox,false,false,2) 
		 maVBoxAppli.pack_start(maVBoxF5)


		# ------------------------- ----------------
		#      Les signaux pour cette frame
		# -----------------------------------------
		
		#signal pour charger un document selon la combobox
		@combo.signal_connect('changed'){
		   #on reper le titre du document
		   titre=@combo.active_text
		   #on recupere le numero du document
		   id=@idTitre[titre]
		   #on remplace le document courant
		 @doc=Document.charger(id)
		 viderListe(sourceStoreF5)
		 viderListe(destinStoreF5)
		 remplirListeSource(sourceStoreF5,@doc)
		 remplirListeDestin(destinStoreF5,@doc)
		}
		
		
		
		
		
		
		  # graphique : Le bouton de transfert de gauche à droite
		  btn1F5.signal_connect('clicked') {|sel, element|
		    sel=sourceListeF5.selection
		    adetruire=Array.new
		    sel.selected_each {|model,path,iter|
		      # On stocke dans un tableau les éléments à détruire
		      #  on ne peut pas les détruire pendant l'itération
		      adetruire.push(iter)     
		      element=destinStoreF5.append()
		      element[0]=iter.get_value(0)
		      element[1]=iter.get_value(1)
		      element[2]=iter.get_value(2)
		      
		      #metier
		      u=Utilisateur.charger(element[0])
		      @doc.ajouterContributeur(u)
		      
		    }
		    # maintenant il reste à détruire
		    adetruire.each {|ind|
			sourceStoreF5.remove(ind)
		    }
		}
		  
		  
		  
		  
		  # Le bouton de transfert de tout de gauche à droite
		  btn3F5.signal_connect('clicked') {|element|
		    sourceStoreF5.each {|ele|
		      element=destinStoreF5.append()
			element[0]=ele[2].get_value(0)
			element[1]=ele[2].get_value(1)
			element[2]=ele[2].get_value(2)
			
			#metier
			u=Utilisateur.charger(element[0])
			@doc.ajouterContributeur(u)
			
		    }
		    sourceStoreF5.clear
		  }
		  
		  # Le bouton de transfert de droite à gauche
		  btn2F5.signal_connect('clicked') {|sel, element|
		    sel=destinListeF5.selection
		    adetruire=Array.new
		    sel.selected_each {|model,path,iter|
		      # On stocke dans un tableau les éléments à détruire
		      #  on ne peut pas les détruire pendant l'itération
		      adetruire.push(iter)     
		      element=sourceStoreF5.append()
		      element[0]=iter.get_value(0)
		      element[1]=iter.get_value(1)
		      element[2]=iter.get_value(2)
		      
		      #metier
		      u=Utilisateur.charger(element[0])
		      @doc.retirerContributeur(u)
		      
		    }
		    # maintenant il reste à détruire
		    adetruire.each {|ind|
			destinStoreF5.remove(ind)
		    }
		}
		  
		 
		  
		  # Le bouton de transfert de tout de droite à gauche
		  btn4F5.signal_connect('clicked') {|element|
		    destinStoreF5.each {|ele|
		      element=sourceStoreF5.append()
			element[0]=ele[2].get_value(0)
			element[1]=ele[2].get_value(1)
			element[2]=ele[2].get_value(2)
			
			u=Utilisateur.charger(element[0])
			@doc.retirerContributeur(u)
		    }
		    destinStoreF5.clear
		  }


		  # On peut aussi quitter avec la croix de la fenetre ou en appuyant sur le bouton annuler.
		  monApplication.signal_connect('destroy') {
		    Gtk.main_quit()
		  }
		  
		  btnAnnuler.signal_connect('clicked') {
		    monApplication.destroy()
		  }
		  
		   btnValider.signal_connect('clicked') {
		    print "Donnees sauvegardees !\n"
		    if ( prive.active?())
			    @doc.visibilitePublique=false
		   else 
			   if(public.active?())
			   @doc.visibilitePublique=true
			   end
		    end
		    @doc.enregistrer()
		    quickMessage("\n Vos modifications ont bien ete sauvegardes \n")
		    
		  }


		# Construction de l'application
		monApplication.add(maVBoxAppli)
		monApplication.show_all
		Gtk.main
  end
end
