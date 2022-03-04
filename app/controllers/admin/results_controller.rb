class Admin::ResultsController < ApplicationController

  def index
    @submissions = Submission.count
  end
  


  private
end
