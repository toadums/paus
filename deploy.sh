coffee -o deploy/ server.coffee
rm -rf deploy/public
cp -rf public deploy

cd deploy
ls
jitsu deploy
