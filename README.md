## Description

[![Build Status](https://travis-ci.com/tvdeyen/csv_mapper.svg?branch=master)](https://travis-ci.com/tvdeyen/csv_mapper)

This gem adds an import action in every controller you like to be able to handle csv imports.
It includes the complete workflow:

* CSV file upload
* Field mapping with review
* Creating model records

## Requirements

Rails >= 3.2 and Ruby >= 2.0*

## Installation

Install as gem:

```bash
gem install csv_mapper
```

Or in your apps `Gemfile`:

```rb
gem 'csv_mapper', github: 'tvdeyen/csv_mapper'
```

## Usage

### Set up a new route to point to the import action (get & post will be needed!):

```rb
# config/routes.rb
resources :myresource do
  collection do
    get :import
    post :import
  end
end
```

### Include it in your Controller:

```rb
# app/controllers/my_resource_controller.b
class MyResourceController
  include CSVMapper::ControllerActions
end
```

### Set up the fields to map to:

```rb
# app/controllers/my_resource_controller.b
class MyResourceController
  include CSVMapper::ControllerActions

  csv_mapper_config(
    mapping: {
      "Firstname" => :firstname,
      "Lastname"  =>  :lastname
    }
  )
end
```

**See also the implementation in [`spec/dummy`](spec/dummy/) app!**

## Customizing

Nearly any part of the gem can be overridden!

### The views

To override the views place a `csv_mapper` folder inside your apps `app/views` folder.

* `import.html.erb` => The import view, where the form is placed on
* `mapper.html.erb` => The mapper view, where the mapping happens
* `import_errors.html.erb` => The import errors view, where import errors while be shown

### The actions

To override the actions just define the method you want to override inside your controller.

Just have a look into [`lib/controller_actions.rb`](lib/csv_mapper/controller_actions.rb) file to see the methods.

## Thanks

This gem is heavily based on [Andrew Timberlake's map-fields-gem](https://github.com/internuity/map-fields).

Nevertheless we didn't fork it, because the changes were too fundamental.

## License

[MIT License](MIT-LICENSE)
