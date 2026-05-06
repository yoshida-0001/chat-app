require 'rails_helper'

RSpec.describe "ユーザーログイン機能", type: :system do
  it 'ログインしていない状態でトップページにアクセスした場合、サインインページに遷移する' do
    # トップページに遷移する
    visit root_path
    # ログインしていない場合、サインインページに遷移することを確認する
    expect(page).to have_current_path(new_user_session_path)
  end

  it 'ログインに成功し、トップページに遷移する' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    # サインインページへ移動する
    visit root_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(page).to have_current_path(new_user_session_path)
    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    # ログインボタンをクリックする
    click_on ('Log in')
    # トップページに遷移していることを確認する
    expect(page).to have_current_path(root_path)
  end

  it 'ログインに失敗し、再びサインインページに戻ってくる' do
        # 予め、ユーザーをDBに保存する
         @user = FactoryBot.create(:user)
        # トップページに遷移する
        visit root_path
        # ログインしていない場合、サインインページに遷移していることを確認する
         expect(page).to have_current_path(new_user_session_path)
        # 誤ったユーザー情報を入力する
        fill_in 'user_email', with: 'aaa@bbb'
        fill_in 'user_password', with: 'aaabbb'
        # ログインボタンをクリックする
        click_on ('Log in')
        # サインインページに戻ってきていることを確認する
        expect(page).to have_current_path(new_user_session_path)
  end 
end
