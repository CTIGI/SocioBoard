namespace :imports do
  desc "Copy Passwords from ctigi auth"
  task :copy_passwords => [:environment] do
    ctigi_auth_url = Figaro.env.ctigi_auth_app_url

    conn = Faraday.new(url: ctigi_auth_url)

    User.all.each do |user|
      response = conn.get "/import_password/#{user.ctigi_auth_uid}"

      if response.status == 200
        user.encrypted_password = response.body
        user.save
      end
    end
  end

end
