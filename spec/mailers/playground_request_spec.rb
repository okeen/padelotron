require "spec_helper"

describe PlaygroundRequest do
  describe "ask_mail" do
    let(:mail) { PlaygroundRequest.ask_mail }

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
    let(:mail) { PlaygroundRequest.confirmation_mail }

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
    let(:mail) { PlaygroundRequest.cancellation_mail }

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
