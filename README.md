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

- Сконфигурируйте базу данных **config/database.yml** (PostgreSQL);

- Выполните необходимые миграции базы данных:

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

Для работы с пользователями (регистрация и аутентификация) часто используется гем **Devise**,
поэтому я решил огранизовать приложение вокруг этой библиотеки. В рамках задачи, в настройках Devise
были отключены опции, требующие подтверждения регистрации пользователя.

#### Route List
---

**Source file**: [route list](https://github.com/includetasks/08.02.2016_ARKIS/blob/master/config/routes.rb)

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
                user PATCH  /users/:id(.:format)                 users#update
                     PUT    /users/:id(.:format)                 users#update
                     DELETE /users/:id(.:format)                 users#destroy
```

- **/sample** - страница, **доступная любому пользователю**;
- **/signed-sample** - страница, доступная только **аутентифицированному** пользователю;
- **/sign-in** - страница входа на сайт;
- **/users** - страница со списком пользователей;;
- **/users/new** - страница с формой создания нового пользователя;
- **/users/:id/change-password** - страница смены пароля пользователя;
- **/users/:id/edit** - страница редактирования данных пользователя.

#### Controller List
---

```bash
./app/controllers
├── ./app/controllers/application_controller.rb
├── ./app/controllers/concerns
├── ./app/controllers/errors_controller.rb
├── ./app/controllers/frontpages_controller.rb
├── ./app/controllers/users
│   └── ./app/controllers/users/sessions_controller.rb
└── ./app/controllers/users_controller.rb
```

- **[ApplicationController](https://github.com/includetasks/08.02.2016_ARKIS/blob/master/app/controllers/application_controller.rb)** - баззовый контроллер приложения (без изменений);
- **[ErrorsController](https://github.com/includetasks/08.02.2016_ARKIS/blob/master/app/controllers/errors_controller.rb)** - минимальная реализация контроллера обработки ошибок (404/500);
- **[FrontpagesController](https://github.com/includetasks/08.02.2016_ARKIS/blob/master/app/controllers/frontpages_controller.rb)** - контроллер, обрабатывающий запросы к страницам Sample и Signed Sample;
- **[Users/SessionsController](https://github.com/includetasks/08.02.2016_ARKIS/blob/master/app/controllers/users/sessions_controller.rb)** - контроллер, наследуемый от Devise/Session-контроллера. Реализован для
возможности перехвата момента, когда **неактивированный** пользователй пытается аутентифицироваться.
- **[UsersController](https://github.com/includetasks/08.02.2016_ARKIS/blob/master/app/controllers/users_controller.rb)** - контроллер, реализующий работу с юзерами (CRUD).


#### UI
---

UI написан с использованием фрэймворка **[Material Design Lite](https://github.com/cllns/material_design_lite-rails)** совместно с **[Material Icons](https://github.com/Angelmmiguel/material_icons)**.

#### Тесты (RSpec)
---

Были написаны несколько поверхностных feature-тестов (для ключевых моментов) и минимальный набор Unit-тестов (для модели User).

- **feature**: [User tries to create a user](https://github.com/includetasks/08.02.2016_ARKIS/blob/master/spec/features/create_user_spec.rb)
- **feature**: [User tries to sign in](https://github.com/includetasks/08.02.2016_ARKIS/blob/master/spec/features/user_tries_to_sign_in_spec.rb)
- **feature**: [User tries to visit sample pages](https://github.com/includetasks/08.02.2016_ARKIS/blob/master/spec/features/user_tries_to_visit_pages_spec.rb)
- **model**: [User Model](https://github.com/includetasks/08.02.2016_ARKIS/blob/master/spec/models/user_spec.rb)

#### Документирование
---

Ввиду отсутствия необходимости полного комментирвоания проекта, закомментировал
некоторые ключевые моменты модели User, аннотации к экшнам контроллеров (METHOD + URI) и
автоматически сгенерировал database-аннотации к контроллерам и моделям с помощью гема Annotate.


Демонстрация
============

#### Добавление пользователей
---


#### Редактирование пользователей
---

#### Попытка входа АКТИВИРОВАННЫМ пользователем
---

#### Попытка входа НЕ АКТИВИРОВАННЫМ пользователем
---

#### Переходы на страницы /sample и /signed-sample АКТИВИРОВАННЫМ пользователем
---

#### Переходы на страницы /sample и /signed-sample НЕ АКТИВИРОВАННЫМ пользователем
---