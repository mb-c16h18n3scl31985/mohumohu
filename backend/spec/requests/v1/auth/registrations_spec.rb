require 'rails_helper'

RSpec.describe "API::V1::Registrations", type: :request do
  let(:header) { { "X-Requested-With" => "XMLHttpRequest" } }

  context "POST /api/v1/auth サインアップ" do
    team = FactoryBot.create(:team)
    header = { "X-Requested-With" => "XMLHttpRequest" }
    password = Faker::Internet.password
    params = { name: Faker::Internet.username,
               email: Faker::Internet.unique.email,
               password: password,
               password_confirmation: password,
               team_id: team.id
    }

    it '200 ok' do
      post "/api/v1/auth", headers: header, params: params
      expect(response.status).to eq(200)
    end

    it '特定データの作成' do
      post "/api/v1/auth", headers: header, params: params
      json = JSON.parse(response.body)
      expect(json['data']['name']).to eq(params[:name])
    end
  end

  context 'POST api/v1/auth/sign_in サインイン' do
    header = { "X-Requested-With" => "XMLHttpRequest" }
    user = FactoryBot.create(:user)
    params = { email: user.email, password: user.password }

    it '200 ok' do
      post "/api/v1/auth/sign_in", headers: header, params: params
      expect(response.status).to eq(200)
    end
  end

  context "PUT api/v1/auth/password パスワードの変更" do
    team = FactoryBot.create(:team)
    header = { "X-Requested-With" => "XMLHttpRequest" }
    sign_up_params = { name: Faker::Internet.username,
                       email: Faker::Internet.unique.email,
                       password: "password",
                       password_confirmation: "password",
                       team_id: team.id
    }
    it '200 ok' do
      # 一度サインアップする
      post "/api/v1/auth", headers: header, params: sign_up_params

      password = Faker::Internet.password

      # サインアップの値をヘッダーに含む
      headers = { "X-Requested-With" => "XMLHttpRequest",
                  "access-token" => response.header["access-token"],
                  "uid" => response.header["uid"],
                  "client" => response.header["client"]
      }
      update_params = { "password" => password, "password_confirmation" => password }

      # パスワード変更のリクエスト
      put "/api/v1/auth", headers: headers, params: update_params
      debugger
      expect(response.status).to eq(200)
    end

  end
end

