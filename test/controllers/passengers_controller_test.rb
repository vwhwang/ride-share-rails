require "test_helper"

describe PassengersController do

  describe "index" do
    it "responses to get" do
      get passengers_path 

      must_respond_with :success 
    end 
  end

  describe "show" do
    it "responses to get id" do 
      valid_id = 1 
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
