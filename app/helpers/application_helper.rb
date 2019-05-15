module ApplicationHelper

  def smart_listing_render_controller name = controller_name, *args
    options = args.dup.extract_options!
    
    smart_listing_for(name, *args) do |smart_listing|
      concat(smart_listing.render_list(options[:locals]))
    end
  end
  
  def render_list locals = {}
    if @smart_listing.partial
      @template.render :partial => @smart_listing.partial, :locals => {:smart_listing => self}.merge(locals || {})
    end
  end

  def admin?
    current_user.try(:admin?)
  end
end

