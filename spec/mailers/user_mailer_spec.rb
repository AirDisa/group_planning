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
      mail.from.should == ['grouppact@gmail.com']
    end

    it "should have access to user's name in the body" do
      mail.body.encoded.should match(user.first_name)
    end

  end

  describe 'event invitee' do
    let(:user)  { FactoryGirl.build(:user)  }
    let(:event) { FactoryGirl.build(:event) }
    let(:mail)  { UserMailer.event_invitee("test@test.com", user, event) }

    it 'should render the subject' do
      mail.subject.should == "#{user.first_name} invited you to a grouPACT event!"
    end

    it 'should renders the correct user email' do
      mail.to.should == ["test@test.com"]
    end

    it 'should render the correct sender email' do
      mail.from.should == ['grouppact@gmail.com']
    end

    it "should have access to creator's name in the body" do
      mail.body.encoded.should match(user.first_name)
    end

    it "should have access to event title in the body" do
      mail.body.encoded.should match(event.title)
    end

  end

end
