class PagesController < ApplicationController

  def issue_326
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'issue_326'
      end
    end
  end

end