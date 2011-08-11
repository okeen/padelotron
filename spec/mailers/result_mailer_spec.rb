require "spec_helper"

describe ResultMailer do
  describe "ask_mail" do
    let(:mail) { ResultMailer.ask_mail }

    it "renders the headers" do
      mail.subject.should eq("Ask mail")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "confirmation_mail" do
    let(:mail) { ResultMailer.confirmation_mail }

    it "renders the headers" do
      mail.subject.should eq("Confirmation mail")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "cancellation_mail" do
    let(:mail) { ResultMailer.cancellation_mail }

    it "renders the headers" do
      mail.subject.should eq("Cancellation mail")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
