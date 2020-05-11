require "test_helper"

describe WelcomeController do
  it "must get index" do
    get welcome_index_url
    must_respond_with :success
  end

end
