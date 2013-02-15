# Kaleidoscope

Kaleidoscope is color search for Rails using Active Record. The intent behind it was to index a database of images by color for quick retrieval.

Kaleidoscope works by running histograms on images and converting their top 5 colors into [L*a*b* color space](http://en.wikipedia.org/wiki/Lab_color_space) for a more approximate representation of human vision. Colors are then matched to a specified set of colors using Euclidean distance. The gem will store hexidecimal values of the image's original color and the matched color, along with the frequency of that color within the image (for sorting based on frequency).

Since L*a*b* relies so heavily on lightness, matches for white, black, and grey will all be quite poor compared to other color types.

## Requirements

### Image Processor

[ImageMagick](http://www.imagemagick.org/) must be installed and Kaleidoscope must have access to it. To ensure that it does, on your command line, run `which convert` (one of the ImageMagick utilities). This will give you the path where that utility is installed. For example, it might return `/usr/local/bin/convert/`.

Then, in your environment config file, let Kaleidoscope know where to look by adding that directory to its path.

In development mode, you might add this line to `config/environments/development.rb`:

```
Kaleidoscope.options[:command_path] = "/usr/local/bin/"
```

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

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
