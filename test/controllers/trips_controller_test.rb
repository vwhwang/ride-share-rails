require "test_helper"

describe TripsController do
  describe "show" do
    before do 
      @passenger = Passenger.create(name: "BoB", phone_num:"XXX-XXX-OOOO")
      @driver = Driver.create(name: "Areeb Milner", vin: "adadadad345ad", available: true)
      @trip = Trip.create(date: DateTime.now,cost: 100, passenger:@passenger, driver:@driver )
    end 
    it "responde to trip show page" do 
      trip_id = @trip.id

      get trip_path(trip_id)

      must_respond_with :success
    end 

    it "not found page for invalid trip id" do 
      invalid_id = -1 

      get trip_path(invalid_id)

      must_respond_with :not_found 
    end 
  end

  describe "create" do

    before do 
      @passenger = Passenger.create(name: "BoB", phone_num:"XXX-XXX-OOOO")
      @driver = Driver.create(name: "Areeb Milner", vin: "adadadad345ad", available: true)
    end 

    it "can create a new trip" do 
      trip = Trip.create(date: DateTime.now,cost: 100, passenger:@passenger, driver:@driver )
      expect(trip.errors).must_be_empty
      expect(trip.driver.name).must_equal "Areeb Milner"
      expect(trip.passenger.name).must_equal "BoB"
    end 

  end

  describe "edit" do
    before do 
      @passenger = Passenger.create(name: "BoB", phone_num:"XXX-XXX-OOOO")
      @driver = Driver.create(name: "Areeb Milner", vin: "adadadad345ad", available: true)
      @trip = Trip.create(date: DateTime.now,cost: 100, passenger:@passenger, driver:@driver )
    end 

    it "response to edit page with valid trip" do
      get edit_trip_path(@trip.id)
      must_respond_with :success
    end 

    it "response to not found if invalid trip id" do 
      get edit_trip_path(-1)
      must_respond_with :not_found
    end 

  end

  describe "update" do
    before do 
      @passenger = Passenger.create(name: "BoB", phone_num:"XXX-XXX-OOOO")
      @driver = Driver.create(name: "Areeb Milner", vin: "adadadad345ad", available: true)
      @trip = Trip.create(date: DateTime.now,cost: 100, passenger:@passenger, driver:@driver, rating: 0 )

    end 

    let (:edit_trip) do
      {
        trip: {
          rating: 2,
          date: DateTime.now,
          driver:@driver,
          passenger:@passenger,
          cost:100
        },
      }
    end

    let (:invalid_trip) do
      {
        trip: {
          rating: 2,
          date: nil,
          driver:@driver,
          passenger:@passenger,
          cost:1000
        },
      }
    end
        
    it "can update an existing trip" do

      id = @trip.id
      expect{ patch trip_path(id), params: edit_trip }.wont_change "Trip.count"

      trip = Trip.find_by(id:id)
      expect(trip.rating).must_equal 2
      must_respond_with  :redirect

    end

    it "will not update with invalid date blank" do

      id = @trip.id
      expect{ patch trip_path(id), params: invalid_trip }.wont_change "Trip.count"
      trip = Trip.find_by(id:id)
      expect(trip.rating).wont_equal invalid_trip[:trip][:rating]
      expect(trip.cost).wont_equal invalid_trip[:trip][:cost]

    end


  end

  describe "destroy" do
    before do 
      @passenger = Passenger.create(name: "BoB", phone_num:"XXX-XXX-OOOO")
      @driver = Driver.create(name: "Areeb Milner", vin: "adadadad345ad", available: true)
      @trip = Trip.create(date: DateTime.now,cost: 100, passenger:@passenger, driver:@driver, rating: 0 )
    end 


    it "will delete the trip" do 
      trip = @trip

      expect {
        delete trip_path(trip.id) 
      }.must_differ "Trip.count" , -1

      must_redirect_to passengers_path
    end 

    it "if invalid trip id no data deleted " do
      delete trip_path(-1)
      must_respond_with :not_found
    end
  end
end
