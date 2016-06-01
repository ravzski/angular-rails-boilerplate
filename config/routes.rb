Rails.application.routes.draw do


  namespace :api, defaults: { format: 'json' } do
    scope module: :v1 do
      
      resource :session, only: %i(show create destroy)

    end
  end

  get "*path" => "application#index"
  root to: "application#index"
end
