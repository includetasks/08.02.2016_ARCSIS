Rails.application.routes.draw do
  get '404', to: 'errors#not_found'
  get '500', to: 'errors#internal_server_error'

  root 'frontpages#sample'

  get '/sample',        to: 'frontpages#sample'
  get '/signed-sample', to: 'frontpages#signed_sample'

  devise_for :users, path: '',
    skip: [:registrations, :passwords],
    path_names: {
      sign_in:  'sign-in',
      sign_out: 'sign-out'
    },
    controllers: {
      sessions: 'users/sessions'
    }

  resources :users, except: [:show] do
    get 'change-password', on: :member
  end
end
