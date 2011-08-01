require "spec_helper"

describe GameConfirmationMailer do
  describe "friendly_game_confirmation_email" do
    let(:mail) { GameConfirmationMailer.friendly_game_confirmation_email }

    it "renders the headers" do
      mail.subject.should eq("Friendly game confirmation email")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
