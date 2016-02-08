Simple Users panel
==================

> простое web-приложение, реализующее локигу администрирования пользователей

Установка и запуск development-среды
-------------------------------------

- Склонируйте репозиторий:

```bash
git clone
```

- Установите/обновите необходимые гемы:

```bash
bundle install
bundle update
```

- Сконфигурируйте базу данных *config/database.yml* (PostgreSQL):

```ruby
rake db:migrate db:test:prepare
```

- Заполните базу данных тестовыми данными:

```bash
rake db:seed
````

- Запустите Rails-приложение:

```bash
rails server
```

Нюансы реализации
-----------------

* Для работы с пользователями (регистрация и аутентификация) часто используется гем Devise,
поэтому я решил огранизовать приложение вокруг этой библиотеки.

##### Route list:

```bash
              Prefix Verb   URI Pattern                          Controller#Action
                     GET    /404(.:format)                       errors#not_found
                     GET    /500(.:format)                       errors#internal_server_error
                root GET    /                                    frontpages#sample
              sample GET    /sample(.:format)                    frontpages#sample
       signed_sample GET    /signed-sample(.:format)             frontpages#signed_sample
    new_user_session GET    /sign-in(.:format)                   users/sessions#new
        user_session POST   /sign-in(.:format)                   users/sessions#create
destroy_user_session DELETE /sign-out(.:format)                  users/sessions#destroy
change_password_user GET    /users/:id/change-password(.:format) users#change_password
               users GET    /users(.:format)                     users#index
                     POST   /users(.:format)                     users#create
            new_user GET    /users/new(.:format)                 users#new
           edit_user GET    /users/:id/edit(.:format)            users#edit
                user GET    /users/:id(.:format)                 users#show
                     PATCH  /users/:id(.:format)                 users#update
                     PUT    /users/:id(.:format)                 users#update
                     DELETE /users/:id(.:format)                 users#destroy
```