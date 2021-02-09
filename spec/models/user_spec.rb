require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "should save successfully with all fields present, matching passwords, and a unique email in the database" do
      @user = User.create(name: "Natasha Colusso", email: 'natasha@gmail.com', password: 'natasha1', password_confirmation: 'natasha1')
      expect(@user.errors).to be_empty
    end

    it "should should not save when the password and confirmation do not match" do
      @user = User.create(name: "Natasha Colusso", email: 'natasha@gmail.com', password: 'natasha1', password_confirmation: 'natasha2')
      
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "should should not save when password confirmation is not included" do
      @user = User.create(name: "Natasha Colusso", email: 'natasha@gmail.com', password: 'natasha1', password_confirmation: nil)
      
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")   
    end
    
    it "should should not save when password is not included" do
      @user = User.create(name: "Natasha Colusso", email: 'natasha@gmail.com', password: nil, password_confirmation: 'natasha1')
      
      expect(@user.errors.full_messages).to include("Password can't be blank")   
    end

    it "should should not save when email is not included" do
      @user = User.create(name: "Natasha Colusso", email: nil, password: 'natasha1', password_confirmation: 'natasha1')
      
      expect(@user.errors.full_messages).to include("Email can't be blank")   
    end

    it "should should not save when name is not included" do
      @user = User.create(name: nil, email: 'natasha@gmail.com', password: 'natasha1', password_confirmation: 'natasha1')
      
      expect(@user.errors.full_messages).to include("Name can't be blank")   
    end

    it "should should not save when a user with that email already exists" do
      @user1 = User.create(name: "Natasha Colusso", email: 'natasha@gmail.com', password: 'natasha1', password_confirmation: 'natasha1')
      @user2 = User.create(name: "Natasha C", email: 'natasha@gmail.com', password: 'natasha2', password_confirmation: 'natasha2')
      
      expect(@user2.errors.full_messages).to include("Email has already been taken")   
    end

    it "should should not save when a user with that email already exists (case sensitive)" do
      @user1 = User.create(name: "Natasha Colusso", email: 'natasha@gmail.com', password: 'natasha1', password_confirmation: 'natasha1')
      @user2 = User.create(name: "Natasha C", email: 'Natasha@gmail.COM', password: 'natasha2', password_confirmation: 'natasha2')
      
      expect(@user2.errors.full_messages).to include("Email has already been taken")   
    end

    it "should should not save when the password is under 6 characters" do
      @user = User.create(name: "Natasha Colusso", email: 'natasha@gmail.com', password: 'nat', password_confirmation: 'nat')
      
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")   
    end
  end

  describe ".authenticate_with_credentials" do
    it "return an instance of the user if successfully authenticated" do
      @user = User.create(name: "Natasha Colusso", email: 'natasha@gmail.com', password: 'natasha1', password_confirmation: 'natasha1')
      @test_user = User.authenticate_with_credentials('natasha@gmail.com', 'natasha1')
      expect(@user).to eq(@test_user)
    end
    it "return an instance of the user if successfully authenticated and is not case sensitive" do
      @user = User.create(name: "Natasha Colusso", email: 'natasha@gmail.com', password: 'natasha1', password_confirmation: 'natasha1')
      @test_user = User.authenticate_with_credentials('natasha@GMAIL.com', 'natasha1')
      expect(@user).to eq(@test_user)
    end
    it "return an instance of the user if successfully authenticated and removes leading/trailing whitespace" do
      @user = User.create(name: "Natasha Colusso", email: 'natasha@gmail.com', password: 'natasha1', password_confirmation: 'natasha1')
      @test_user = User.authenticate_with_credentials('  natasha@gmail.com  ', 'natasha1')
      expect(@user).to eq(@test_user)
    end
    it "returns nil if the user doesn't exist" do
      @user = User.create(name: "Natasha Colusso", email: 'natasha@gmail.com', password: 'natasha1', password_confirmation: 'natasha1')
      @test_user = User.authenticate_with_credentials('natasha1@gmail.com', 'natasha1')
      expect(@test_user).to eq(nil)
    end
    it "returns nil if the password does not match" do
      @user = User.create(name: "Natasha Colusso", email: 'natasha@gmail.com', password: 'natasha1', password_confirmation: 'natasha1')
      @test_user = User.authenticate_with_credentials('natasha@gmail.com', 'natasha11')
      expect(@test_user).to eq(nil)
    end
  end
end
