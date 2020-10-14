require 'rails_helper'
Sidekiq::Testing.fake!

RSpec.describe ImageZipController, :type => :request do
  let(:site_id)         { '1' }
  let(:email)           { 'email@thing.com' }
  let(:params)          {{ site_id: site_id, email: email }}
  
  tmp_user_folder =  "tmp/archive_submissions" 
  let(:expected_directory_suffix) { '1'}

  describe "GET #get_images" do
    after(:all) do
      FileUtils.rm_rf(Dir["#{tmp_user_folder}/*"]) 
      FileUtils.rm_rf(Dir["#{tmp_user_folder}"]) 
    end
    context "without authentication" do
      before {get '/admin/zip_images'}
      it "returns http success" do
        # expect(response).to have_http_status(401)
        # expect(response.body).to include("Bad Credentials")
      end
    end

    context "with authentication" do
      headers = { 'Authorization' => "Token #{ENV["API_TOKEN"]}" }
      subject { get '/admin/zip_images', params: params, headers: headers, as: :json }
       
      it "returns http success" do
        subject
        expect(response).to have_http_status(:redirect)
      end

      Sidekiq::Testing.inline! do
        it "calls submission zip worker" do
          expect{ subject }.to change(SubmissionZipWorker.jobs, :size).by(1) 
        end

        it "uses supplied email address" do
          expect(SubmissionZipWorker).to receive(:perform_async).with(expected_directory_suffix, site_id, email)
          subject
        end
        
        context 'without email supplied' do
          let(:params) {{site_id: site_id}}
          it "uses default email address if none supplied" do
            expect(SubmissionZipWorker).to receive(:perform_async).with(expected_directory_suffix, site_id, ENV["DESIGNATED_EMAIL"])
            subject
          end
        end
      end
    end
  end
  


  describe "GET #download_zip" do

    context "without authentication" do
      before { get '/admin/download_zip' }
      xit "returns http success" do
        # expect(response).to have_http_status(401)
        # expect(response.body).to include("Bad Credentials")
      end
    end

    context "with authentication" do
      headers = { 'Authorization' => "Token #{ENV["API_TOKEN"]}" }
      let(:public_url) { 'www.images.zip' }
      
      
      subject { get '/admin/download_zipped_images', params: { site_id: site_id }, headers: headers, as: :json }

      context "if zip file present" do
        before do
          obj = double("S3 object", public_url: public_url, exists?: true)
          aws = double("AWS", object: obj)
          
          allow_any_instance_of(Aws::S3::Resource)
            .to receive(:bucket)
            .and_return(aws)
        end
                
        it "downloads file" do
          subject
          expect(flash[:notice]).to be_present
          expect(response).to redirect_to(public_url)
        end
        
      end

      context "if zip file not present" do
        before do
          obj = double("S3 object", public_url: public_url, exists?: false)
          aws = double("AWS", object: obj)
          
          allow_any_instance_of(Aws::S3::Resource)
            .to receive(:bucket)
            .and_return(aws)
        end

        it "redirects back" do
          subject
          expect(flash[:alert]).to be_present
          expect(response).to redirect_to('/admin/results')
        end
      end
    end
  end
end