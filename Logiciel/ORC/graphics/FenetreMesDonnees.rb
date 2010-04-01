require 'gtk2'

include Gtk

##############################################################################
# Projet L3 Groupe 2 : classe FenetreMesDonnees
#
#
# dernière modification :	30/03/06, Max
# todo : 
##############################################################################


class FenetreMesDonnees
	
	#creer fenetre FenetreMesDonnees
	def initialize(utilisateur)
		fenetreMesDonnees = Window.new()
		fenetreMesDonnees.set_title("Mes Donnees")
		fenetreMesDonnees.modal = true
		fenetreMesDonnees.window_position= Gtk::Window::POS_CENTER
		
		#taille de la fenetre
		fenetreMesDonnees.set_default_size(200,100)
		
		fenetreMesDonnees.signal_connect('destroy'){
				fenetreMesDonnees.destroy()
			}

		frame = Frame.new()
		#table Container
		tableContainer = Table.new(4, 2)

		labelId = Label.new("identifiant")
		labelId2 = Label.new(utilisateur.nom)
		labelEmail = Label.new("E-mail")
		champEmail = Entry.new()
		champEmail.text=utilisateur.eMail
		labelMdp = Label.new("Mot de Passe")
		champMdp = Entry.new()
		champMdp.text=utilisateur.motDePasse

		#bouton Modifier
		btnModifier = Button.new(Stock::APPLY)
		
		btnModifier.signal_connect('clicked') do
			if (utilisateur.eMail!=champEmail.text() or utilisateur.motDePasse!=champMdp.text())
				utilisateur.modifierDonnees(champEmail.text(), champMdp.text())
				quickMessage("Vos donnees ont ete modifiees.")
				fenetreMesDonnees.destroy()
			else
				fenetreMesDonnees.destroy()
			end
		end
	
		#bouton annuler
		btnAnnuler = Button.new(Stock::CANCEL)
		btnAnnuler.signal_connect('clicked') do 
			fenetreMesDonnees.destroy()
		end


		#tableau (g, d, h, b)
		tableContainer.attach(labelId, 0, 1, 0, 1)
		tableContainer.attach(labelId2, 1, 2, 0, 1)
		tableContainer.attach(labelEmail, 0, 1, 1, 2)
		tableContainer.attach(champEmail, 1, 2, 1, 2)
		tableContainer.attach(labelMdp, 0, 1, 2, 3)
		tableContainer.attach(champMdp, 1, 2, 2, 3)
		tableContainer.attach(btnAnnuler, 0, 1, 3, 4)
		tableContainer.attach(btnModifier, 1, 2, 3, 4)


		frame.add(tableContainer)
		fenetreMesDonnees.add(frame)
		fenetreMesDonnees.show_all()
	end
end
