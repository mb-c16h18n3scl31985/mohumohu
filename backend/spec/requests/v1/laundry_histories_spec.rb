require 'rails_helper'

RSpec.describe "LaundryHistoriesAPI", type: :request do

  describe 'GET /api/v1/laundry_histories' do
    subject(:get_laundry_histories) { get "/api/v1/laundry_histories", headers: auth_tokens }
    let(:auth_tokens) { sign_in(users.first) }
    let(:json) { JSON.parse(response.body) }

    context '同じチームの洗濯履歴がある場合' do
      # 同じチームに属するデータを作成
      let(:team) { FactoryBot.create(:team) }
      let(:users) { FactoryBot.create_list(:user, 2, team_id: team.id) }
      let(:laundries) { FactoryBot.create_list(:laundry, 2, team_id: team.id) }
      before :each do
        FactoryBot.create(:laundry_history, user_id: users.first.id, laundry_id: laundries.first.id)
        FactoryBot.create(:laundry_history, user_id: users.last.id, laundry_id: laundries.last.id)
      end

      it '同じチームの履歴が取得できること' do
        subject
        expect(response.status).to eq(200)
        expect(json['data'].length).to eq(2)
      end
    end

    context '違うチームの履歴がある場合' do
      let(:users) { FactoryBot.create_list(:user, 2) }

      let(:first_laundry) { FactoryBot.create(:laundry, user_id: users.first.id, team_id: users.first.team_id) }
      let(:second_laundry) { FactoryBot.create(:laundry, user_id: users.last.id) }

      before :each do
        FactoryBot.create(:laundry_history, user_id: users.first.id, laundry_id: first_laundry.id)
        FactoryBot.create(:laundry_history, user_id: users.last.id, laundry_id: second_laundry.id)
      end

      it '違うチームの履歴は取得できないこと' do
        subject
        expect(response.status).to eq(200)
        expect(json['data'].length).to eq(1)
      end
    end
  end

  describe "GET /api/v1/laundry_histories/:id" do
    context "同じチームの履歴がある場合" do
      let(:team) { FactoryBot.create(:team) }
      let(:users) { FactoryBot.create_list(:user, 2, team_id: team.id) }
      let(:auth_tokens) { sign_in(users.first) }
      let(:laundry) { FactoryBot.create(:laundry, user_id: users.second.id, team_id: team.id) }
      before :each do
        FactoryBot.create(:laundry_history, user_id: users.first.id, laundry_id: laundry.id)
        FactoryBot.create(:laundry_history, user_id: users.last.id, laundry_id: laundry.id)
      end

      it "履歴を取得できていること" do
        get "/api/v1/laundry_histories/#{laundry.id}", headers: auth_tokens

        expect(response.status).to eq(200)
        json = JSON.parse(response.body)

        expect(json['data'].length).to eq(2)
      end
    end

    context "違うチームの履歴がある場合" do

    end
  end
  #
  # describe "POST /api/v1/laundry_histories"  do
  #   let(:user) { FactoryBot.create(:user) }
  #   let(:laundry) { FactoryBot.create(:laundry, user_id: user.id, team_id: user.team_id) }
  #
  #   let(:auth_tokens) { sign_in(user) }
  #
  #   it "洗濯履歴の作成" do
  #     expect { post "/api/v1/laundry_histories", headers: auth_tokens, params: { laundry_id: laundry.id } }
  #       .to change(LaundryHistory, :count).by(+1)
  #
  #     expect(response.status).to eq(200)
  #   end
  # end
  #
  # describe "DELETE /api/v1/laundry_histories/:id" do
  #   # サインイン
  #   let(:user) { FactoryBot.create(:user) }
  #   let(:auth_tokens) { sign_in(user) }
  #
  #   let(:laundry) { FactoryBot.create(:laundry, user_id: user.id, team_id: user.team_id) }
  #   let!(:laundry_history){ FactoryBot.create(:laundry_history, user_id: user.id, laundry_id: laundry.id)}
  #
  #   it "DELETE /api/v1/laundry_histories/:id" do
  #     delete "/api/v1/laundry_histories/#{laundry_history.id}", headers: auth_tokens
  #
  #     json = JSON.parse(response.body)
  #     expect(json['data']['deleted_at']).not_to eq(nil)
  #     expect(response.status).to eq(200)
  #   end
  # end

  # context do
  #   let!(:user) { FactoryBot.create(:user) }
  #   let!(:laundry) { FactoryBot.create(:laundry, user_id: user.id, team_id: user.team_id) }
  #   let!(:laundry_history){ FactoryBot.create(:laundry_history, user_id: user.id, laundry_id: laundry.id)}
  #
  #   let(:auth_tokens) { sign_in(user) }
  #   let(:json) { JSON.parse(response.body) }

  # it "GET /api/v1/laundry_histories/:id" do
  #   get "/api/v1/laundry_histories/#{laundry.id}", headers: auth_tokens
  #
  #   expect(response.status).to eq(200)
  #
  #   if json["data"].first
  #     expect(json['data'].first["laundry_id"]).to eq(laundry.id)
  #   end
  # end
  #
  # it "POST /api/v1/laundry_histories" do
  #   expect { post "/api/v1/laundry_histories", headers: auth_tokens, params: { laundry_id: laundry.id } }
  #     .to change(LaundryHistory, :count).by(+1)
  #
  #   expect(response.status).to eq(200)
  # end
  #
  #   it "DELETE /api/v1/laundry_histories/:id" do
  #     delete "/api/v1/laundry_histories/#{laundry_history.id}", headers: auth_tokens
  #
  #     expect(json['data']['deleted_at']).not_to eq(nil)
  #     expect(response.status).to eq(200)
  #   end
  # end
end