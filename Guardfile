require 'verbal_expressions'
# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# Be cautios to comment the below line. Would scan for all directories.
directories %w(lib spec)

## Uncomment to clear the screen before every task
clearing :on

## Guard internally checks for changes in the Guardfile and exits.
## If you want Guard to automatically start up again, run guard in a
## shell loop, e.g.:
##
##  $ while bundle exec guard; do echo "Restarting Guard..."; done
##
## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"
#
# This group allows to skip running RuboCop when RSpec failed.
group :red_green_refactor, halt_on_fail: true do
  # I am using verbal expression to humanize the regular expression
  # For debugging pattern use :
  # puts pattern_for_lib.source

  # Pattern for any file ending with rb in lib folder
  pattern_for_lib = VerEx.new do
    start_of_line
    find 'lib'
    find '/'
    anything
    find '.rb'
    end_of_line
  end

  # Pattern for any file ending with _spec.rb in spec folder
  pattern_for_spec = VerEx.new do
    start_of_line
    find 'spec'
    find '/'
    anything
    find '_spec.rb'
    end_of_line
  end

  guard :rspec, cmd: 'rspec -f d' do
    # Running all tests if lib or spec files changes
    watch(pattern_for_lib) { 'spec' }
    watch(pattern_for_spec) { 'spec' }

    # For Additional debugging purposes look at
    # https://github.com/guard/guard
    # /wiki/Understanding-Guard#heres-a-incorrect-example
  end

  guard :rubocop, all_on_start: false do
    # Running all tests if lib or spec files changes
    # watch('lib/label.rb')
    watch(pattern_for_lib)
    watch(pattern_for_spec)
  end
end
