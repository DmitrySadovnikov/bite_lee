module Api::V1
  class LinksController < ApplicationController
    def create
      link = Link.create!(
        original: params.require(:link),
        suffix: Link.gen_suffix
      )

      render json: { result: link.short }, status: :created
    end

    def handle_get
      redirect_to(link.original)
    end

    def handle_post
      response = Curl.post(link.original, request.body.read) do |curl|
        curl.headers = request.headers.env.reject { |key| key.to_s.include?('.') }
        curl.headers['RAW_POST_DATA'] = nil
        curl.headers['Content-Type'] = 'application/json'
        curl.headers['Accept'] = 'application/json'
      end
      render json: response.body, status: response.status
    end

    private

    def link
      @link ||= Link.find_by(suffix: params.require(:suffix))
    end
  end
end
