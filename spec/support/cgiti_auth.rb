OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:ctigi_auth] = OmniAuth::AuthHash.new({provider: "ctigi_auth",
                                                                      uid: "1",
                                                                     info: { email: "test@example.com" },
                                                              credentials: { token: "123456" }
                                                               })
