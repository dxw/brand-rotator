# dxw's brand rotator

Automate rotating branding colour themes

## Setup

1. Create a [new app](https://developer.twitter.com/apps) on the Twitter account
   you want to manage

   You will need to record the app's consumer key, consumer secret, access
   token, and access token secret. Set them as secrets in GitHub called
   `TWITTER_CONSUMER_KEY`, `TWITTER_CONSUMER_SECRET`, `TWITTER_ACCESS_TOKEN`,
   and `TWITTER_ACCESS_TOKEN_SECRET` respectively.

1. Set up Gravatar

   Set the primary Gravatar email address and password as secrets in GitHub
   called `GRAVATAR_EMAIL` and `GRAVATAR_PASSWORD` respectively.

## Usage

This runs automatically every day at around 4am via GitHub Actions. After setup,
no human interaction should be required.

## Development

This repository uses the
[scripts to rule them all pattern](https://github.com/github/scripts-to-rule-them-all).

### Getting started

Run

```
script/setup
```

to perform all the required setup.

### Staying up to date

Run

```
script/update
```

to bring your local environment up to date.

### Running tests

Run

```
script/test
```

to run the full test suite.
