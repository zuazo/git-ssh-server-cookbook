#!/usr/bin/env bats

@test "should create repository directories" {
  [ -d /srv/git/repo1.git ]
  [ -d /srv/git/repo2.git ]
  [ -d /srv/git/app3.git ]
}

@test "should initialize repositories" {
  [ -d /srv/git/repo1.git/objects ]
  [ -d /srv/git/repo2.git/objects ]
  [ -d /srv/git/app3.git/objects ]
}

@test "should create an update hook" {
  [ -f /srv/git/repo2.git/hooks/post-update ]
}

@test "should create valid repositories" {
  cd /srv/git/repo1.git/ && \
  git branch
  cd /srv/git/repo2.git/ && \
  git branch
  cd /srv/git/app3.git/ && \
  git branch
}

@test "should be able to clone bare repositories" {
  cd /tmp && \
  rm -rf repo1 && \
  git clone /srv/git/repo1.git
}

