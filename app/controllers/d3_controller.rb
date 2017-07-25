class D3Controller < ApplicationController

  def machrie
    respond_to do |format|
      images = Image.all.where(site: 'MACHRIE').to_json
      format.json  { render :json => images } # don't do msg.to_json
      format.csv { send_data images, filename: "machrie-#{Date.today}.csv" }
    end
  end
end
