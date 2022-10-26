require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User Validations' do
    before(:each) do
      @user = User.new(name: 'John Wick',
                       email: 'jardani@gmail.com',
                       password: 'Belarus64',
                       password_confirmation: 'Belarus64')
    end

    it 'is valid with valid attributes' do
      expect(@user).to be_valid
    end

    it 'should not be valid without a name' do
      @user.name = nil
      expect(@user).not_to be_valid
    end

    it 'should not be valid without an email' do
      @user.email = nil
      expect(@user).not_to be_valid
    end

    it 'should not be valid if the password does not match the confirmation' do
      @user.password_confirmation = 'Mexico'
      expect(@user).not_to be_valid
    end

    it 'should not accept a user with the same email address' do
      @user.save!
      @duplicate_user = User.new(
        name: 'Wick Wannabe',
        email: 'JARDANI@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect { @duplicate_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(@duplicate_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'should not accept a user with a password less than 8 characters' do
      @user.password = 'imshort'
      @user.password_confirmation = 'imshort'
      expect(@user).not_to be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.new(name: 'John Wick',
                       email: 'jardani@gmail.com',
                       password: 'Belarus64',
                       password_confirmation: 'Belarus64')
      @user.save!
    end
    it 'should log a user in with valid credentials' do
      login = User.authenticate_with_credentials('jardani@gmail.com', 'Belarus64')
      expect(login).to eq(@user)
    end

    it 'should not log user in with invalid password' do
      login = User.authenticate_with_credentials('jardani@gmail.com', 'WrongPassword')
      expect(login).not_to eq(@user)
    end

    it 'should not log user in with invalid email' do
      login = User.authenticate_with_credentials('wrong@gmail.com', 'Belarus64')
      expect(login).not_to eq(@user)
    end

    it 'should accept an email address with white space before and/or after' do
      login = User.authenticate_with_credentials('  jardani@gmail.com  ', 'Belarus64')
      expect(login).to eq(@user)
    end

    it 'should accept an email address regardless of case' do
      login = User.authenticate_with_credentials('JARDANI@GMAIL.COM', 'Belarus64')
      expect(login).to eq(@user)
    end

    it 'should return nil when password and email are not found' do
      login = User.authenticate_with_credentials('johnwick@aol.com', 'Mexico')
      expect(login).to be_nil
    end
  end
end
