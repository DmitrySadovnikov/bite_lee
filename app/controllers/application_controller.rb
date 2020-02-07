class ApplicationController < ActionController::API
  rescue_from StandardError do |exception|
    case exception
    when ActionController::ParameterMissing
      render json: { error: exception.message }, status: :bad_request
    when ActiveRecord::RecordNotFound
      render json: { error: 'Resource not found' }, status: :not_found
    when ActiveRecord::RecordInvalid
      render json: { error: exception.message }, status: :bad_request
    else
      render json: { error: exception.message.to_s }, status: :internal_server_error
    end
  end

  def hc
    head :ok
  end
end
