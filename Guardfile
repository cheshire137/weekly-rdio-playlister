# vim: set ft=ruby :

# A sample Guardfile
# More info at https://github.com/guard/guard#readme

# Sample guardfile block for Guard::Haml
# You can use some options to change guard-haml configuration
# output: 'public'                   set output directory for compiled files
# input: 'src'                       set input directory with haml files
# run_at_start: true                 compile files when guard starts
# notifications: true                send notifictions to Growl/libnotify/Notifu
# haml_options: { ugly: true }    pass options to the Haml engine
guard 'haml', input: '.', output: 'public' do
  watch %r(^.+\.haml$)
end

guard 'coffeescript', input: '.', output: 'public/js' do
  watch %r(^.+\.coffee$)
end

guard :lessc, in_file: 'screen.less', out_file: 'public/css/screen.css',
              compress: true do
  watch %r(^.+\.less$)
end
