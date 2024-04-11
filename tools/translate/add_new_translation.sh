python -m pip install --upgrade pip
pip install -r ./tools/translator/requirements.txt

git fetch origin
git config --local user.email "action@github.com"
git config --local user.name "ss220bot"

git checkout -b translate_tmp
git reset --hard origin/master

git checkout translate -- ./tools/translator/ss220replace.json
git commit -m "Move old translation"

git cherry-pick translate

python ./tools/translator/converter.py
git add ./tools/translator/ss220replace.json
git commit -m "Generate translation file"
git reset .

git push origin translate_tmp:translate
