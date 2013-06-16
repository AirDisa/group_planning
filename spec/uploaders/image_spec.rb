require 'carrierwave/test/matchers'

describe ImageUploader do
  include CarrierWave::Test::Matchers

  before do
    ImageUploader.enable_processing = true
    @event     = FactoryGirl.create(:event)
    @uploader = ImageUploader.new(@event, :image)
    @uploader.store!(File.open(Rails.root.join "app", "assets", "images", "rails.png"))
  end

  after do
    ImageUploader.enable_processing = false
    @uploader.remove!
  end

  context 'thumb version' do
    it "should scale down an image to fit within 64 by 64 pixels" do
      @uploader.thumb.should be_no_larger_than(64, 64)
    end
  end

  context 'normal version' do
    it "should scale down a large image to fit within 600 by 600 pixels" do
      @uploader.should be_no_larger_than(600, 600)
    end
  end

  context 'permissions' do
    it "should make the image readable only to the owner and not executable" do
      @uploader.should have_permissions(0600)
    end
  end

end
