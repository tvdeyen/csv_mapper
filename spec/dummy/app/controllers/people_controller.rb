class PeopleController < ApplicationController
  include CSVMapper::ControllerActions

  csv_mapper_config(
    mapping: {
      "Firstname" => :firstname,
      "Lastname"  => :lastname
    }
  )

  def index
    @people = Person.all
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    redirect_to(people_url)
  end
end
