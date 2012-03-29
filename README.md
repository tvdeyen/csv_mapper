## Description

[![Build Status](https://secure.travis-ci.org/magiclabs/csv_magic.png?branch=master)](http://travis-ci.org/magiclabs/csv_magic)

This gem adds an import action in every controller you like to be able to handle csv imports.
It includes the complete workflow:

* CSV file upload
* Field mapping with review
* Creating model records

## Requirements

Rails >= 3.1.x and Ruby >= 1.9.x

## Installation

Install as gem:

    $ gem install csv_magic

Or in your apps `Gemfile`:

    gem 'csv_magic', :git => 'git://github.com/magiclabs/csv_magic.git'

## Usage

### Set up a new route to point to the import action (get & post will be needed!):

    # routes.rb
    resources :myresource do
      get 'import', :on => :collection
      post 'import', :on => :collection
    end

### Include it in your Controller:

    include CSVMagic::ControllerActions

### Set up the fields to map to:

    # your_controller.rb
    csv_magic_config(
      :mapping => {
        "Firstname" => :firstname,
        "Lastname"  =>  :lastname
      }
    )

**See also the implementation in `spec/dummy` app!**

## Customizing

Nearly any part of the gem can be overridden!

### The views

To override the views place a `csv_magic` folder inside your apps `app/views` folder.

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
