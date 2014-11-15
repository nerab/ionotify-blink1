# ionotify::blink1

Changes the blink1 color when a file changes.

Notification tool that changes the color of a blink1 when a watched file changes its contents.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ionotify-blink1'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ionotify-blink1

## Usage

    ionb1-show RGB 128 64 12

    ionb1-pattern {success | pending | failed}

    ionb1-watch FILE [*FILES]
