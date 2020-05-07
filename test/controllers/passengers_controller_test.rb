require "test_helper"

describe PassengersController do

  describe "index" do
    it "responses to get" do
      get passengers_path 

      must_respond_with :success 
    end 
  end

  describe "show" do

    before do 
      @passenger = Passenger.create(name: "BoB", phone_num:"XXX-XXX-OOOO")
    end 

    it "responses to get id" do 
      valid_id = @passenger.id
      
      get passenger_path(valid_id)

      must_respond_with :success
    end 
  end

  describe "new" do
    # Your tests go here
  end

  describe "create" do
    # Your tests go here
  end

  describe "edit" do
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
