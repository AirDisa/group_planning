require "spec_helper"

describe UserMailer do

  describe 'welcome email' do
    let(:user) { FactoryGirl.build(:user) }
    let(:mail) { UserMailer.welcome_email(user) }

    it 'should render the subject' do
      mail.subject.should == 'Welcome to grouPACT!'
    end

    it 'should renders the correct user email' do
      mail.to.should == [user.email]
    end

    it 'should render the correct sender email' do
      mail.from.should == ['notifications@groupact.it']
    end

    it "should have access to user's name in the body" do
      mail.body.encoded.should match(user.first_name)
    end

  end

end
