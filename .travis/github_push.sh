#!/bin/sh
setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit_and_push() {
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
  #git push https://${GH_TOKEN}@github.com/thbonk/CocoaCutter.git
  git push
}

setup_git
commit_and_push


