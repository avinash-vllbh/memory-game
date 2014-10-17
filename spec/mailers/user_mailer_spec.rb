require "rails_helper"

describe UserMailer, :type => :mailer do
  describe ".notify_email" do
    context "Invalid parameters" do
      it "doesn't send an email if invalid url parameter is given" do
        # http is missing in the below passed url
        UserMailer.notify_email("admin@memorygame-demo.com", "memorygame-demo.com/games/1231243213").deliver
        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end
      it "catches invalid email addresses and doesn't send an email" do
        # http is missing in the below passed url
        UserMailer.notify_email("adminmemorygame-demo.com", "http://memorygame-demo.com/games/1231243213").deliver
        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end
    end
    context "Valid parameters" do
      it "sends email to the email address passed in as parameter" do
        UserMailer.notify_email("admin@memorygame-demo.com", "http://memorygame-demo.com/games/1231243213").deliver
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end
    end
  end
end
