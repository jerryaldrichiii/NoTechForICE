# #NoTechForICE

Jerry does not support GitHub's contract with ICE. This updates his
contribution graph to reflect that.

## Usage

If you want to do the same to your repo, do this:

```
sudo docker build -t notechforice .

eval $(ssh-agent -s)

# Enter your password...you have one set for your SSH private key...right?
ssh-add

#####################################################################
#  REPLACE THESE VALUES
#####################################################################

# This one MUST MATCH YOUR GITHUB EMAIL to render correctly
export GITHUB_USER_EMAIL="REPLACE_ME@example.com"

export GITHUB_REPO="git@github.com:REPLACE_ME/NoTechForICE.git"

#####################################################################

# ONLY RUN THIS AFTER DOING THE ABOVE
sudo docker run --rm \
  -v "$(pwd):/app" \
  -v "$SSH_AUTH_SOCK:/ssh-agent" \
  -e SSH_AUTH_SOCK=/ssh-agent \
  -e GITHUB_USER_EMAIL="$GITHUB_USER_EMAIL" \
  -e GITHUB_REPO="$GITHUB_REPO" \
  notechforice
```

## Attribution

Many thanks to https://github.com/Annihil/github-spray/ for making this
possible.

