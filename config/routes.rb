Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :links, only: %i[create]
    end
  end

  get 'hc' => 'application#hc'
  get '*suffix', to: 'api/v1/links#handle_get'
  post '*suffix', to: 'api/v1/links#handle_post'
end
