:: 設定
set GITHUB_ID=eorfeorf
set REPO_TYPE=public
set IGNORE="Unity"
set LICENSE="MIT"
set DESCRIPTION=" "
set ISSUES=false
set WIKI=false

@echo off
setlocal
popd %~dp0

:: フォルダ名を取得.
:: なぜか末尾が消えるので\をつけ足してる.
set THIS_PATH=%1\
echo %THIS_PATH%
for %%1 in ("%THIS_PATH:~0,-1%") do set REPO_NAME=%%~nx1
echo %REPO_NAME%

:: ローカルを初期化.
pushd "./%REPO_NAME%"
git init -b main
popd

:: Githubのリポジトリを作成.
gh repo create %REPO_NAME% --%REPO_TYPE% -g=%IGNORE% --license=%LICENSE% -d=%DESCRIPTION% --enable-issues=%ISSUES% --enable-wiki=%WIKI% -y

:: リモートを追加.
set REPO_URL=https://github.com/%GITHUB_ID%/%REPO_NAME%.git

pushd "./%REPO_NAME%"

:: 生成されたファイルをローカルに.
git remote add origin %REPO_URL%
git pull origin main

:: Rider用に.gitignoreを修正.
echo # Rider>>.gitignore
echo .idea/>>.gitignore

:: 全部をプッシュ.
git add .
git commit -m "First commit"
git push -u origin HEAD:main
