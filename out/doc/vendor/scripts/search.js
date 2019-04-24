$( '.ui.search' )
.search
({
  type  : 'standard',
  minCharacters : 3,
  maxResults : 10,
  cache : true,
  apiSettings:
  {
    url: '/search?q={query}'
  }
})

