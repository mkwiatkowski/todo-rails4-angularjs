# Showcase of Rails 4 and AngularJS integration

This is a todo list management application, written in Rails 4 and AngularJS. Tasks support CRUD operations as well as drag&drop sorting and setting due dates via a popup calendar. All task operations are done on the client side and synchronized to the server. The application sports a RESTful API used by AngularJS SPA and also usable standalone.

Check out the demo at [todo-rails4-angularjs](http://todo-rails4-angularjs.shellyapp.com/).

I wrote [an article that summarizes all the lessons learned during writing of this app](https://shellycloud.com/blog/2013/10/how-to-integrate-angularjs-with-rails-4). I also did a presentation about this integration at Ruby User Group in Sopot on September 18th. Check out [the slides](http://mkwiatkowski.github.io/angularjs-rails4-trug-presentation/).

## Technologies used

### Frontend

 - [Bootstrap 3.0.0](http://getbootstrap.com/)
 - [AngularJS 1.2.16](http://angularjs.org/)
 - [jQuery 1.10.2](http://jquery.com/)
 - [jQuery UI 1.10.3](http://jqueryui.com/)
 - [CoffeeScript 1.6.3](http://coffeescript.org/)
 - [Slim 2.0.1](http://slim-lang.com/)
 - [Sass 3.2.10](http://sass-lang.com/)
 - [Karma 0.10.2](http://karma-runner.github.io/)
 - [Jasmine 1.3.1](http://pivotal.github.io/jasmine/)
 - [editablespan](https://github.com/mkwidzinska/editablespan)
 - [ui-sortable](https://github.com/angular-ui/ui-sortable)

### Backend

 - [Ruby 2.0.0p247](http://www.ruby-lang.org/en/)
 - [Ruby on Rails 4.0.0](http://rubyonrails.org/)
 - [Devise 3.0.3](https://github.com/plataformatec/devise)
 - [active_model_serializers 0.8.1](https://github.com/rails-api/active_model_serializers)
 - [acts_as_list 0.3.0](https://github.com/swanandp/acts_as_list)
 - [Rspec 2.14](http://rspec.info/)
 - [factory_girl 4.2.0](https://github.com/thoughtbot/factory_girl)
