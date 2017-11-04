require 'rails_helper'

RSpec.describe User, type: :model do
    let(:user) { User.create!(email: "liam@blocipedia.com", password: "password") }
  
  #Shoulda tests for email
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }
  it { is_expected.to allow_value("user@blocipedia.com").for(:email) }
  
  #Shoulda tests for password
  it { is_expected.to validate_presence_of(:password) }
  #it { is_expected.to have_secure_password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }
  
  describe "attributes" do
      it "should have email attribute" do
          expect(user).to have_attributes(email:user.email)
      end
      
      it "responds to role" do
          expect(user).to respond_to(:role)
      end
      
      it "responds to admin?" do
          expect(user).to respond_to(:admin?)
      end
      
      it "responds to standard?" do
          expect(user).to respond_to(:standard?)
      end
      
      it "responds to premium?" do
          expect(user).to respond_to(:premium?)
      end
  end
  
  describe "user role" do
      it "defaults to :standard" do
          expect(user.standard?).to be_truthy
      end
      
      context "standard user" do
          it "returns true for #standard" do
              expect(user.standard?).to be_truthy
          end
          
          it "returns false for #admin" do
              expect(user.admin?).to be_falsey
          end
          
          it "returns false for #premium" do
              expect(user.premium?).to be_falsey
          end
      end
      
      context "premium user" do
          before do
              user.premium!
          end
          
        it "returns false for #standard" do
            expect(user.standard?).to be_falsey
        end
          
        it "returns false for #admin" do
            expect(user.admin?).to be_falsey
        end
          
          it "returns true for #premium" do
              expect(user.premium?).to be_truthy
          end
      end
      
      context "admin user" do
          before do
              user.admin!
          end
          
          it "returns false for #standard" do
              expect(user.standard?).to be_falsey
          end
          
          it "returns true fro #admin" do
              expect(user.admin?).to be_truthy
          end
          
          it "returns false for #premium" do
              expect(user.premium?).to be_falsey
          end
      end
  end

end
