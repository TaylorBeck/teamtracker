module RsvpHelper
  def rsvp_class(rsvp)
    if rsvp.response == "yes"
      return "button-yes"
    elsif rsvp.response == "no"
      return "button-no"
    end
  end
end
