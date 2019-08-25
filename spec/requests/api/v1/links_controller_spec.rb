require 'rails_helper'

describe Api::V1::LinksController do
  describe '#create' do
    subject { post '/api/v1/links', headers: headers, params: params.to_json }

    let(:headers) do
      {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }
    end

    let(:params) do
      {
        link: Faker::Internet.url
      }
    end

    before do
      allow(Link).to receive(:gen_suffix).and_return('XXX')
    end

    it 'creates short links' do
      expect { subject }.to change { Link.count }.by(1)
    end

    it 'creates campaign with correct attributes' do
      subject
      expect(Link.last).to have_attributes(
        original: params[:link],
        suffix: 'XXX'
      )
    end

    it 'returns 201' do
      subject
      expect(response).to have_http_status(201)
    end

    it 'returns correct json' do
      subject
      expect(json_response).to eq('result' => 'http://localhost:3000/XXX')
    end
  end

  describe '#handle_get' do
    subject { get "/#{link.suffix}" }

    let(:link) { create(:link, suffix: 'XXX') }

    it 'returns 302' do
      subject
      expect(response).to have_http_status(302)
    end

    it 'returns 302' do
      subject
      expect(response).to redirect_to(link.original)
    end
  end

  describe '#handle_post' do
    subject { post "/#{link.suffix}", headers: headers, params: params.to_json }

    let(:headers) do
      {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }
    end

    let(:params) { { lol: 'kek' } }
    let(:expected_response) { { aaa: 'bbb' } }
    let(:link) { create(:link, suffix: 'XXX') }

    [200, 400, 500].each do |code|
      context "when response #{code}" do
        before do
          stub_request(:post, link.original)
            .with(
              body: params.to_json,
            )
            .to_return(status: code, body: expected_response.to_json, headers: {})
        end

        it "returns #{code}" do
          subject
          expect(response).to have_http_status(code)
        end

        it 'returns correct json' do
          subject
          expect(json_response).to eq(expected_response.as_json)
        end
      end
    end
  end
end
