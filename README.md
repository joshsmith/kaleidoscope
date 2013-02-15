# Kaleidoscope

[![Build Status](https://travis-ci.org/JoshSmith/kaleidoscope.png?branch=master)](https://travis-ci.org/JoshSmith/kaleidoscope) [![Dependency Status](https://gemnasium.com/JoshSmith/kaleidoscope.png)](https://gemnasium.com/JoshSmith/kaleidoscope) [![Code Climate](https://codeclimate.com/github/JoshSmith/kaleidoscope.png)](https://codeclimate.com/github/JoshSmith/kaleidoscope)

Kaleidoscope is color search for Rails using Active Record and Paperclip. The intent behind it was to index a database of images by color for quick retrieval.

Kaleidoscope works by running histograms on images and converting their top *n* colors (by frequency) into [L*a*b* color space](http://en.wikipedia.org/wiki/Lab_color_space) for a more approximate representation of human vision. Colors are then matched to a specified set of colors using Euclidean distance. The gem will store hexadecimal values of the image's original color and the matched color, along with the frequency of that color within the image (for sorting based on frequency) and the Euclidean distance (for sorting by tolerance).

Since L*a*b* relies so heavily on lightness, matches for white, black, and grey will all be quite poor compared to other color types.

Here's an example of what Kaleidoscope can do:

![Kaleidoscope Example](http://cl.ly/image/3n2C16170i0k/Screen%20Shot%202013-02-05%20at%206.56.44%20PM.png)

## Requirements

### Paperclip

Currently Kaleidoscope requires you to have [Paperclip](https://github.com/thoughtbot/paperclip) already run on the model you want indexed for color search.

In the future, it would be nice if Paperclip were not a requirement and Kaleidoscope could work with, say, CarrierWave.

### Image Processor

[ImageMagick](http://www.imagemagick.org/) must be installed and Kaleidoscope must have access to it via [RMagick](https://github.com/rmagick/rmagick). To ensure that it does, on your command line, run `which convert` (one of the ImageMagick utilities). This will give you the path where that utility is installed. For example, it might return `/usr/local/bin/convert/`.

If you're on Mac OS X, you'll want to run the following with Homebrew:

```
brew install imagemagick
```

## Installation

Add this line to your application's Gemfile:

    gem 'kaleidoscope'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kaleidoscope

## Usage

Generate your migration by specifying the Paperclip model, e.g. `Photo`:

```bash
rails generate kaleidoscope photo
```

This will generate the model `PhotoColor`.

Alternatively, in your models:

```ruby
class Photo < ActiveRecord::Base
  has_many :photo_colors
end

class PhotoColor < ActiveRecord::Base
  belongs_to :photo

  attr_accessible :photo_id, :distance, :frequency, :original_color, :reference_color
end
```

And in your migrations:

```ruby
class AddPhotoColors < ActiveRecord::Migration
  def change
    create_table :photo_colors do |t|
      t.integer :photo_id
      t.string :original_color
      t.string :reference_color
      t.float :frequency
      t.integer :distance

      t.timestamps
    end

    add_index :photo_colors, :photo_id
    add_index :photo_colors, :original_color
    add_index :photo_colors, :reference_color
    add_index :photo_colors, :frequency
    add_index :photo_colors, :distance
  end
end
```

In your controller:

```ruby
def index
  @photos = Photo.all.with_color(params[:color])
end
```

To refresh the color database:

```bash
rake kaleidosocope:refresh
```

## Contributing

Please submit pull requests! I'd love to feature you as a contributor. Here's a guide:

1. Fork the repo.
2. Run the tests. We only take pull requests with passing tests.
3. Add a test for your change. Only refactoring and documentation changes require no new tests. If you are adding functionality or fixing a bug, we need a test.
4. Make the test pass.
5. Push to your fork and submit a pull request.

We'll review your changes, comment, and then accept or throw it back to you for improvement.

### Syntax

* Two spaces, no tabs.
* No trailing whitespace.
* Prefer &&/II over and/or.
* a = b and not a=b
* Follow conventions you see used in the source already.

## TODO

1. Enable Kaleidoscope to work without requiring Paperclip. Ideally, any database of images should be searchable and we don't want to be tied down to one specific gem.