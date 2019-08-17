export DISABLE_SPRING=1

if [ -d "~/.rvm" ]; then source ~/.rvm/scripts/rvm && cd . && bundle install; fi

case $1 in
  s)
    exec rerun 'bundle exec rails s'
    ;;
  c)
    exec bundle exec rails c
    ;;
  t)
    exec bundle exec rspec
    ;;
  *)
    exec bundle exec "$@"
    ;;
esac
