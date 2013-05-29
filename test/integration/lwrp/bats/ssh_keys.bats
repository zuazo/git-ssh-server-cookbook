#!/usr/bin/env bats

@test "should create .ssh directory" {
  [ -d  /srv/git/.ssh ]
}

@test ".ssh directory should have the correct privileges" {
  stat --printf='%G:%U:%a' /srv/git/.ssh | grep -qFw 'git:git:700'
}

@test "should create authorized_keys file" {
  [ -f /srv/git/.ssh/authorized_keys ]
}

@test "authorized_keys file should have the correct privileges" {
  stat --printf='%G:%U:%a' /srv/git/.ssh/authorized_keys | grep -qFw 'git:git:600'
}

@test "should grant privileges to the correct keys" {
  egrep -q '^ssh-rsa[[:space:]]+AAABBBCCC[[:space:]]+me@foobar.com$' /srv/git/.ssh/authorized_keys
  egrep -q '^ssh-rsa[[:space:]]+DDDEEEFFF[[:space:]]+you@foobar.com$' /srv/git/.ssh/authorized_keys
  egrep -q '^ssh-dsa[[:space:]]+GGGHHHIII[[:space:]]+superboss$' /srv/git/.ssh/authorized_keys
}

