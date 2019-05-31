## Description

[![Build Status](https://secure.travis-ci.org/magiclabs/csv_mapper.png?branch=master)](http://travis-ci.org/magiclabs/csv_mapper)

This gem adds an import action in every controller you like to be able to handle csv imports.
It includes the complete workflow:

* CSV file upload
* Field mapping with review
* Creating model records

## Requirements

Rails >= 3.2.6 and Ruby >= 1.8.7*

*) If you want to use CSV magic with Ruby 1.8.7 you have to add `gem 'faster_csv'` to your `Gemfile`

## Installation

Install as gem:

    $ gem install csv_mapper

Or in your apps `Gemfile`:

    gem 'csv_mapper', :git => 'git://github.com/magiclabs/csv_mapper.git'
    # Uncomment next line if you want to use csv_mapper with Ruby 1.8
    # gem 'faster_csv', :github => 'glennfu/faster_csv', :platform => :ruby_18

## Usage

### Set up a new route to point to the import action (get & post will be needed!):

    # routes.rb
    resources :myresource do
      get 'import', :on => :collection
      post 'import', :on => :collection
    end

### Include it in your Controller:

    include CSVMapper::ControllerActions

### Set up the fields to map to:

    # your_controller.rb
    csv_mapper_config(
      :mapping => {
        "Firstname" => :firstname,
        "Lastname"  =>  :lastname
      }
    )

**See also the implementation in `spec/dummy` app!**

## Customizing

Nearly any part of the gem can be overridden!

### The views

To override the views place a `csv_mapper` folder inside your apps `app/views` folder.

* `import.html.erb` => The import view, where the form is placed on
* `mapper.html.erb` => The mapper view, where the mapping happens
* `import_errors.html.erb` => The import errors view, where import errors while be shown

### The actions

To override the actions just define the method you want to override inside your controller.

Just have a look into `lib/controller_actions.rb` file to see the methods.

## Thanks

This gem is heavily based on [Andrew Timberlake's map-fields-gem](http://github.com/internuity/map-fields).

Nevertheless we didn't fork it, because the changes are too fundamental.

## License

MIT License. Copyright 2012 [magic labs*](http://magiclabs.de)
