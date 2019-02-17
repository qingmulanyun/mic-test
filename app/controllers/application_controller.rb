class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Exceptions

  rescue_from MicStandardError, with: :render_400_error

  def render_400_error(e)
    render :json => {
        :error => {
            :type => e.class.to_s,
            :code => e.code,
            :message => e.message
        }
    }, :status => 400
  end
end
