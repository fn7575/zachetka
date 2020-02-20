Rails.application.routes.draw do
  devise_for :users
  root 'pals#input'

  get 'pals/input'
  get 'pals/output'
  get 'pals/all'
  get 'pals/create_article'
  get 'pals/delete_article'
  get 'pals/edit_article'
  get 'pals/showall'

  get '/:locale' => 'pals#input'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
