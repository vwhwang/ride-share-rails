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

    it "if invalid passenger id, redirects to all passengers" do 
      in_valid_id = -1
      
      get passenger_path(in_valid_id)

      must_redirect_to passengers_path
    end 
  end

  describe "new" do
    it "responds with success" do
      get "/passengers/new"
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger"do 
      passenger_hash = {
        passenger: {
          name: "Oscar Bob",
          phone_num: "111-222-3333"
        }
      }

      expect {
        post passengers_path, params: passenger_hash
      }.must_differ 'Passenger.count', 1

      must_redirect_to passenger_path(Passenger.last.id )
   end 

   it "will check valid passenger input" do 
  
    invalid_passenger =  {
      name: nil,
      phone_num: "111-222-3333"
    }
    
    passenger = Passenger.create(invalid_passenger)
    expect(passenger.errors).wont_be_empty
    expect(passenger.errors.messages[:name]).must_equal ["can't be blank"]

   end 
  end

  describe "edit" do
    before do 
      @passenger = Passenger.create(name: "Oscar BOB", phone_num: "333-444-5555")
    end 

    it "response to edit page with valid passenger" do
      get edit_passenger_path(@passenger.id)
      must_respond_with :success
    end 

    it "response to not found if invalid passenger id" do 
      get edit_passenger_path(-1)
      must_respond_with :not_found
    end 
  end

  describe "update" do
    before do 
      @passenger = Passenger.create(name: "Oscar BOB", phone_num: "333-444-5555")
    end 

    let (:new_passenger) do
      {
        passenger: {
          name: "Cat little",
          phone_num: "111-222-0000"
        },
      }
    end

    let (:invalid_passenger) do
      {
        passenger: {
          name: nil,
          phone_num: nil
        },
      }
    end
    
    it "can update an existing passenger with valid info and redirect" do

      id = Passenger.last.id

      expect{ patch passenger_path(id), params: new_passenger }.wont_change "Passenger.count"

      passenger = Passenger.find_by(id: id)
      expect(passenger.name).must_equal new_passenger[:passenger][:name]
      expect(passenger.phone_num).must_equal new_passenger[:passenger][:phone_num]

      must_respond_with  :redirect
      must_redirect_to passenger_path(Passenger.last.id)
    end

    it "will not update an passenger with invalid info" do 
      id = Passenger.last.id

      expect{ patch passenger_path(id), params: invalid_passenger }.wont_change "Passenger.count"
      passenger = Passenger.find_by(id: id)
      expect(passenger.name).wont_equal new_passenger[:passenger][:name]
      expect(passenger.phone_num).wont_equal new_passenger[:passenger][:phone_num]
    end 
  end

  describe "destroy" do
    before do 
      @passenger = Passenger.create(name: "Oscar BOB", phone_num: "333-444-5555")
    end 

    it "will delete the passenger" do 
      passenger = Passenger.first 

      expect {
        delete passenger_path(passenger.id) 
      }.must_differ "Passenger.count" , -1

      must_redirect_to passengers_path
    end 

    it "if invalid passenger id no data deleted " do
      delete passenger_path(-1)
      must_respond_with :not_found
    end
  end
end
