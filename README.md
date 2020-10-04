## Installation

Add this line to your application's Gemfile:

```ruby
gem 'velocity_rim_selector'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install velocity_rim_selector

## Usage

Heya, gang! Welcome to my WheelBuilder Rim Selector. This command line interface gem will help you select one of Velocity USA's rims for your next repair or wheelbuilding project.

To begin, run `bin/run` from your terminal once installation is all complete.

Then, make your selections. This gem will guide you through the process.
NOTE: ALL selections (except for search) are made to be performed by number. Typing in a selection may get you a different result than you requested.

#To search by Application
First, select your Application, or how you plan on using the completed wheel. There's a lot of overlap, so if you plan on using a rim for multiple disciplines, you'll likely find a good candidate in the lists to follow. Just think about how you're going to using the bike you're putting the wheel on for 75-90% of the time.

From there you'll be given a list of rims to choose from. The rims are also titled by size, so just pick out the size you'll be using. If you're not sure of that, check the size of the wheels on your current bike or potential bike purchase and go from there.

The interface will then ask you if you wish to see the spec list, then inquire as to your desired spoke count and color. A heavier rider, a rider looking for a stiffer wheel, or a rider looking to carry a lot of cargo should get a higher spoke count. Tandems should consider this as well. Lighter/smaller riders, or riders going for featherweight builds will look for lower spoke counts. Then choose your color. If you make a mistake, just go through to the end, and the interface will confirm your choice. Choose ("n") and the interface will restart your selection.

# Search

The search function allows you to type the exact name of a previously listed rim and view it's specs and allows you to continue the selection process from there. Currently, it doesn't allow for flexible searches, so you'll want to copy and paste from a previously queried list of rims to search for the result. Further development of "Search" as well as a "List all rims" option are in the works, as well as the hub selector, so stay tuned!

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[crankums]/cli_project.

# CLI_project_bits
