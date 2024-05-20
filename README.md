# Fli Video

> FliVideo - Video Asset Management for Content Creators

GPT Link: https://chatgpt.com/c/dd1f4202-a449-45a6-af45-b65d8e544685

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fli_video'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install fli_video
```

## Documentation

### Technical Design Document

The main design document is located here: [Technical Specification](docs/technical-specifications.md)

### Feature List

List of features that are planned for this project: [Feature List](docs/feature-list.md)

### Main Story

As a content creator, I want to create quality videos quickly, so that I can build my YouTube influence

See all [stories](./stories.md)


## Usage

See all [usage examples](./USAGE.md)


## Development

Checkout the repo

```bash
git clone https://github.com/klueless-io/fli_video
```

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. 

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Git helpers used by this project

Add the follow helpers to your `alias` file so that you can use Semantic Commits and have them automatically pushed to GitHub and have the CI/CD pipeline run.

```bash
function kcommit()
{
  echo 'git add .'
  git add .
  echo "git commit -m "$1""
  git commit -m "$1"
  echo 'git pull'
  git pull
  echo 'git push'
  git push
  sleep 3
  run_id="$(gh run list --limit 1 | grep -Eo "[0-9]{9,11}")"
  gh run watch $run_id --exit-status && echo "run completed and successful" && git pull && git tag | sort -V | tail -1
}
function kchore     () { kcommit "chore: $1" }
function kdocs      () { kcommit "docs: $1" }
function kfix       () { kcommit "fix: $1" }
function kfeat      () { kcommit "feat: $1" }
function ktest      () { kcommit "test: $1" }
function krefactor  () { kcommit "refactor: $1" }
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/klueless-io/fli_video. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Fli Video project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/klueless-io/fli_video/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) David Cruwys. See [MIT License](LICENSE.txt) for further details.
