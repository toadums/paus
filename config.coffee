exports.config =
  paths:
    watched: ["client", "vendor"]

  files:
    javascripts:
      defaultExtension: "coffee"
      joinTo:
        'application.js': /^(client)/
        'vendor.js': /^(bower_components|vendor)/
      order:
        before: [
          'coffee/character.coffee'
          'coffee/player.coffee'
          'coffee/npc.coffee'
        ]


    stylesheets:
      defaultExtension: 'scss'
      joinTo:
        'app.css': /^client\/styles\/app.scss/
        'vendor.css': /^bower_components/

  # Activate the brunch plugins
  plugins:
    sass:
      debug: 'comments'

  modules:
    nameCleaner: (path) ->
      path
        # Strip the client/ prefix from module names
        .replace(/^client\//, '')

  server:
    path: "spawn_server.coffee"
    run: yes
    port: 3000