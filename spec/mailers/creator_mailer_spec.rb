require "spec_helper"

describe CreatorMailer do
  
  describe 'welcome email' do
    let(:user)  { FactoryGirl.build(:user) }
    let(:event) { FactoryGirl.build(:event) }
    let(:mail)  { CreatorMailer.event_creation(user, event) }

    it 'should render the subject' do
      mail.subject.should == "You just created #{event.title}!"
    end

    it 'should renders the correct user email' do
      mail.to.should == [user.email]
    end

    it 'should render the correct sender email' do
      mail.from.should == ['notifications@groupact.it']
    end

    it "should have access to the user's name in the body" do
      mail.body.encoded.should match(user.first_name)
    end

    it 'should have access to event name in the body' do
      mail.body.encoded.should match(event.title)
    end

    it 'should display a properly formatted commit date' do
      mail.body.encoded.should match(event.commit_date.strftime("%A, %b %e"))
    end

  end

end
