module ApplicationHelper

  def smart_listing_render_foo name = controller_name, *args
    options = args.dup.extract_options!
    
    smart_listing_for(name, *args) do |smart_listing|
      # binding.pry
      concat(smart_listing.render_list(options[:locals]))
    end
  end
  
  def render_list locals = {}
    binding.pry
    if @smart_listing.partial
      @template.render :partial => @smart_listing.partial, :locals => {:smart_listing => self}.merge(locals || {})
    end
  end
end

