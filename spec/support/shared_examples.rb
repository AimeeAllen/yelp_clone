shared_examples "user is not logged in" do
  it "redirects to root path" do
    no_logged_in_user
    action
    expect(response).to redirect_to(sign_in_path)
    expect(flash[:danger]).not_to be_blank
  end
  # newer syntax - requires a new version of rspec
  #it { should set_flash[:danger].to('You must first login') }
end
