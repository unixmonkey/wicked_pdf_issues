class PagesController < ApplicationController

  def issue_326
    @remember_token = CGI.escape(cookies['remember_token'].to_s)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'issue_326',
          cookie: "_session_id #{@remember_token}"
      end
    end
  end

end