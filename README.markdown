# oyemodern.com
This site is "powered" (if you can call it that) by a super simple static generator. It uses haml/sass, inlines images/svgs, and deploys using (gasp) `scp`.

## Installation
Clone, cd into the direction, and run `bundle install`.

Rename `.env.sample` to `.env` and put in your info.

## Development
For live compilation, from the project root run `bundle exec guard`. This will compile haml and will copy any files from public into the build directory.

If you change `helpers.rb`, you'll need to kill and restart guard.

## Deployment
Run `rake deploy`, which will copy the contents of the build directory to your production server using `scp`.

## License
Content, logos, and photos: All rights reserved.
Code is MIT licensed.

