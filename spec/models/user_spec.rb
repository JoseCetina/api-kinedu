require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    
    context "uniqueness" do
      it "user created" do
        user = User.create(email: "josecetina@gmail.com", password: "pepe619")
        
        expect(user).to be_valid
      end

      it "not valid" do
        User.create(email: "jose.cetina.vega@gmail.com", password: "pepe619")
        user = User.create(email: "jose.cetina.vega@gmail.com", password: "pepe619")
        
        expect(user).to_not be_valid
      end      
    end
  end
end