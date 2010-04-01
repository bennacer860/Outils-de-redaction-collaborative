# -*- coding: utf-8 -*-

def quickMessage(message)		
	dialog = MessageDialog.new($main_app_window, 
			Dialog::DESTROY_WITH_PARENT,
			MessageDialog::INFO,
			MessageDialog::BUTTONS_CLOSE,
			message)
  dialog.title = "ORC " + VERSION_LOG
  dialog.window_position = Gtk::Window::POS_CENTER
	dialog.run
	dialog.destroy
end

def msgConfirmation(message)
	dialog = Gtk::MessageDialog.new($main_app_window, 
                                Gtk::Dialog::DESTROY_WITH_PARENT,
                                Gtk::MessageDialog::QUESTION,
                                Gtk::MessageDialog::BUTTONS_YES_NO,
                                message)
  dialog.title = "Confirmation" 
	dialog.window_position = Gtk::Window::POS_CENTER
	dialog.run do |response|
	  case response
	    when Gtk::Dialog::RESPONSE_YES
		dialog.destroy
		return true
	    else
		dialog.destroy
		return false
	  end
	  
	end
end

def msgConfirmationAvecAnnuler(message)
    dialog = Gtk::Dialog.new("Confirmation",
                             $main_application_window,
                             Gtk::Dialog::DESTROY_WITH_PARENT,
                             [ Gtk::Stock::YES, Gtk::Dialog::RESPONSE_YES ],
			     [ Gtk::Stock::NO, Gtk::Dialog::RESPONSE_NONE ],
			     [ Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_NO ])
		
	dialog.window_position = Gtk::Window::POS_CENTER
	dialog.vbox.add(Gtk::Label.new(message))
	dialog.show_all()
	
	dialog.run do |response|
	  case response
	    when Gtk::Dialog::RESPONSE_YES
		dialog.destroy
		return true
	    when Gtk::Dialog::RESPONSE_NONE
		dialog.destroy
		return false
	    else
		dialog.destroy
		return "Annuler"
	  end
	end
end