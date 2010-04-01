require 'gtk2'

class EventBoxModifParagraphe < Gtk::EventBox
  
  @contenu
  @label
  attr_accessor :contenu
  
  def changerTexte(texte)
    if @label != nil
      self.remove(@label)
    end
    @label = Gtk::Label.new()
    @label.set_markup(texte)
    self.add(@label)
  end
  
end