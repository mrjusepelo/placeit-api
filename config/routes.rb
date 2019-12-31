Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :movies, only: %i[index create] do
    collection do
      get 'by_date'
    end
  end

  resources :reserves, only: :create do
    collection do
      get 'by_date'
    end
  end

end
