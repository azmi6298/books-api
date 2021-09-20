class Api::V1::BaseController < ApplicationController
  def render_success_data(data)
    render json: data, status: :ok
  end

  def render_error_data(message, status)
    payload = {
      error: message
    }
    render json: payload, status: status
  end
end