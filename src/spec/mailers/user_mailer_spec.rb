require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  before do
    @user = FactoryBot.create(:user)
    @user.reset_token = User.new_token
  end
  describe "password_reset" do
    let(:mail) { UserMailer.password_reset(@user) }

    it "renders the headers" do
      expect(mail.subject).to eq("パスワードの再設定")
      expect(mail.to).to eq([@user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      part = mail.body.parts.detect do |p|
        p.content_type == 'text/html; charset=UTF-8'
      end
      mail_body = part.body.raw_source
      expect(mail_body).to include("パスワードの再設定用リンク")
    end
  end

end
