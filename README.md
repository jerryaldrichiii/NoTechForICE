# #NoTechForICE

Jerry does not support GitHub's contract with ICE. This updates his
contribution graph to reflect that.

Many thanks to https://github.com/Annihil/github-spray/ for making this
possible.

## Usage

Delete your current repo and create a new one called NoTechForICE. This is
required to get the history to render.

Then do the following:

```
npm install -g github-spray
github-spray --file NoTechForICE.json
rm -rf .git
mv spray-*/.git .
rm -rf spray-*
git add . && git commit -asvm "#NoTechForICE"

# NOTE: No need to change the hash below it is present in all repos
FILTER_BRANCH_SQUELCH_WARNING=1 git filter-branch \
  -f \
  --msg-filter "sed 's/github-spray/#NoTechForICE/'" \
  4b825dc642cb6eb9a060e54bf8d69288fbee4904..HEAD

git remote add origin git@github.com:jerryaldrichiii/NoTechForICE.git
git push origin master
```
