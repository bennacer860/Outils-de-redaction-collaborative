require 'gtk2'

class EventBoxModifImage < Gtk::EventBox
  
  @contenu
  @image
  attr_accessor :contenu
  
  def changerImage(cheminImage)
    if @image != nil
      self.remove(@image)
    end
    @image = Gtk::Image.new(cheminImage)
    self.add(@image)
  end
  
end