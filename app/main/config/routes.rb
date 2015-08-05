client "/getting_started", action: 'getting_started'
client "/examples", action: 'examples'
client "/docs/{{ language }}", controller: 'docs', action: 'index'
client "/docs", controller: 'docs', action: 'index'
client "/api", action: 'api'
client "/community", action: 'community'
client "/blog", controller: 'blog', action: 'index'
client "/components", action: 'components'


# The main route
client '/'
