cd ~

mkdir EX2
cd EX2


git init
git remote add origin https://github.com/shankar2016/Berkeley-W205.git
git config core.sparseCheckout true
echo "exercise_2/" >> .git/info/sparse-checkout
echo "exercise_2/tweetwordcount/" >> .git/info/sparse-checkout
echo "exercise_2/tweetwordcount/*" >> .git/info/sparse-checkout
git pull origin master

cd exercise_2
cd tweetwordcount

sparse run
