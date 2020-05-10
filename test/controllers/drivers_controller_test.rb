require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.

  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      # Ensure that there is at least one Driver saved
      driver = Driver.create(
        name: "Areeb Milner",
        vin: "adadadad345ad",
        available: true
      )
      # Act
      get drivers_path
      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved
      num_of_dirvers = Driver.all.size
      # Act
      get drivers_path
      # Assert
      must_respond_with :success
      expect(num_of_dirvers).must_equal 0
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
      # Arrange
      # Ensure that there is a driver saved
      driver = Driver.create(
        name: "Areeb Milner",
        vin: "adadadad345ad",
        available: true
      )
      # Act
      get driver_path(driver.id)
      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
      # Arrange
      # Ensure that there is an id that points to no driver
      invalid_id = -1
      # Act
      get driver_path(-1)
      # Assert
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      get "/drivers/new"
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      driver_hash = {
        driver: {
          name: "Areeb Milner",
          vin: "adadadad345ad",
          available: true
        }
      }
      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
      expect { post drivers_path, params: driver_hash}.must_differ "Driver.count", 1
      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      expect(Driver.last.name).must_equal driver_hash[:driver][:name]
      expect(Driver.last.vin).must_equal driver_hash[:driver][:vin]
      expect(Driver.last.available).must_equal driver_hash[:driver][:available]
      # Check that the controller redirected the user
      must_respond_with :redirect
      must_redirect_to driver_path(Driver.last.id)
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Set up the form data so that it violates Driver validations
      driver_hash = {
        driver: {
          available: true
        }
      }
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect { post drivers_path, params: driver_hash }.wont_change "Driver.count", 0
      # Assert
      # Check that the controller redirects
    end
  end
  
  describe "edit" do
    before do
      @driver = Driver.create(name: "Areeb Milner", vin: "adadadad345ad", available: true)
    end

    it "responds with success when getting the edit page for an existing, valid driver" do
      get edit_driver_path(@driver.id)
      must_respond_with :success
    end

    it "responds with not found when getting the edit page for a non-existing driver" do
      get edit_driver_path(-1)
      must_respond_with :not_found
    end
  end

  describe "update" do
    before do
      @driver = Driver.create(name: "Areeb Milner", vin: "adadadad345ad", available: true)
    end
    let (:new_driver_params) do
      {
        driver: {
          name: "Peter Smith",
          vin: "909090909erer",
          available: true
        },
      }
    end
    let (:new_driver2_params) do
      {
        driver: {
          name: "Peter Smith",
          vin: "909090909erer",
          available: false
        },
      }
    end
    let (:new_driver3_params) do
      {
        driver: {
          available: true,
        },
      }
    end


    it "can update an existing driver with valid information accurately, and redirect" do

      id = Driver.last.id

      expect{ patch driver_path(id), params: new_driver_params }.wont_change "Driver.count"

      driver = Driver.find_by(id: id)
      expect(driver.name).must_equal new_driver_params[:driver][:name]
      expect(driver.vin).must_equal new_driver_params[:driver][:vin]
      expect(driver.available).must_equal new_driver_params[:driver][:available]
      must_respond_with  :redirect
      must_redirect_to driver_path(Driver.last.id)
    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      id = -1

      expect { patch driver_path(id), params: new_driver_params }.wont_change "Driver.count"
      must_respond_with :not_found
    end

    it "can toggle the avaiable between true and false" do
      id = Driver.last.id

      expect{ patch change_availability_path(id), params: new_driver2_params }.wont_change "Driver.count"

      driver = Driver.find_by(id: id)
      expect(driver.available).must_equal new_driver2_params[:driver][:available]
      must_respond_with  :redirect
      must_redirect_to driver_path(Driver.last.id)

    end 

    it "does not update a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data so that it violates Driver validations
      id = Driver.last.id
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect { patch driver_path(id), params: new_driver3_params }.wont_change "Driver.count", 0
      # Assert
      # Check that the controller redirects
    end
  end

  describe "destroy" do
    before do
      @driver = Driver.create(name: "Areeb Milner", vin: "adadadad345ad", available: true)
    end

    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved
      id = Driver.last.id
      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count
      expect{ delete driver_path(id)}.must_differ "Driver.count", -1
      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
    end

    it "does not change the db when the driver does not exist, then responds with " do
      delete driver_path(-1)
      must_respond_with :not_found
    end
  end
end
