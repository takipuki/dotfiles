#! /usr/bin/env lua

-- anime links
a_0_9 = "http://172.16.50.9/DHAKA-FLIX-9/Anime%20%26%20Cartoon%20TV%20Series/Anime-TV%20Series%20%E2%98%85%20%200%20%20%E2%80%94%20%209/"
a_a_f = "http://172.16.50.9/DHAKA-FLIX-9/Anime%20%26%20Cartoon%20TV%20Series/Anime-TV%20Series%20%E2%99%A5%20%20A%20%20%E2%80%94%20%20F/"
a_g_m = "http://172.16.50.9/DHAKA-FLIX-9/Anime%20%26%20Cartoon%20TV%20Series/Anime-TV%20Series%20%E2%99%A5%20%20G%20%20%E2%80%94%20%20M/"
a_n_s = "http://172.16.50.9/DHAKA-FLIX-9/Anime%20%26%20Cartoon%20TV%20Series/Anime-TV%20Series%20%E2%99%A6%20%20N%20%20%E2%80%94%20%20S/"
a_t_z = "http://172.16.50.9/DHAKA-FLIX-9/Anime%20%26%20Cartoon%20TV%20Series/Anime-TV%20Series%20%E2%99%A6%20%20T%20%20%E2%80%94%20%20Z/"
-- tv series links
t_0_9 = "http://172.16.50.12/DHAKA-FLIX-12/TV-WEB-Series/TV%20Series%20%E2%98%85%20%200%20%20%E2%80%94%20%209/"
t_a_l = "http://172.16.50.12/DHAKA-FLIX-12/TV-WEB-Series/TV%20Series%20%E2%99%A5%20%20A%20%20%E2%80%94%20%20L/"
t_m_r = "http://172.16.50.12/DHAKA-FLIX-12/TV-WEB-Series/TV%20Series%20%E2%99%A6%20%20M%20%20%E2%80%94%20%20R/"
t_s_z = "http://172.16.50.12/DHAKA-FLIX-12/TV-WEB-Series/TV%20Series%20%E2%99%A6%20%20S%20%20%E2%80%94%20%20Z/"
-- kdrama
k = "http://172.16.50.14/DHAKA-FLIX-14/KOREAN%20TV%20%26%20WEB%20Series/"
-- animations
an = "http://172.16.50.14/DHAKA-FLIX-14/Animation%20Movies%20%281080p%29/"
-- movies are handled elsehwhere


function main()
  _ = io.popen('fzf > /tmp/sam', 'w'):write([[
animations
anime
kdrama
movie
hindi
tv
  ]]):close() or os.exit(1)

  local choice = io.open('/tmp/sam'):read('l')
  local url = ''
  local fn = series_to_eps
  if choice == 'anime' then
    local c = get_alphanum_choice()
    url = (c:match('[0-9]') and a_0_9)
      or (c:match('[a-f]') and a_a_f)
      or (c:match('[g-m]') and a_g_m)
      or (c:match('[n-s]') and a_n_s)
      or (c:match('[t-z]') and a_t_z)

  elseif choice == 'kdrama' then
    url = k

  elseif choice == 'tv' then
    local c = get_alphanum_choice()
    url = (c:match('[0-9]') and t_0_9)
      or (c:match('[a-l]') and t_a_l)
      or (c:match('[m-r]') and t_m_r)
      or (c:match('[s-z]') and t_s_z)

	elseif choice == 'animations' then
		url = an
		fn = movie

  elseif choice == 'movie' then
    local fzf = io.popen('fzf > /tmp/sam', 'w')
    for i=1994,tonumber(os.date("%Y")) do fzf:write(i..'\n') end
    _ = fzf:close() or os.exit(1)
    local y =  io.open('/tmp/sam'):read('l')

    if y == '1994' then
      url = 'http://172.16.50.7/DHAKA-FLIX-7/English%20Movies/%281960-1994%29/'
    else
      url = 'http://172.16.50.7/DHAKA-FLIX-7/English%20Movies/%28'..y..'%29/'
    end

    fn = movie

  elseif choice == 'hindi' then
    local fzf = io.popen('fzf > /tmp/sam', 'w')
    for i=1995,tonumber(os.date("%Y")) do fzf:write(i..'\n') end
    _ = fzf:close() or os.exit(1)
    local y =  io.open('/tmp/sam'):read('l')

    if y == '1995' then
      url = 'http://172.16.50.14/DHAKA-FLIX-14/Hindi%20Movies/%281995%29%20%26%20Before/'
    else
      url = 'http://172.16.50.14/DHAKA-FLIX-14/Hindi%20Movies/%28'..y..'%29/'
    end

    fn = movie
  end

  local content = fn(url)
  io.write("filename: ")
  local filename = io.read() or os.exit(1)
  write_to_m3u((filename:gsub(' +', '_'))..'.m3u', content)
end


function get_alphanum_choice()
  local fzf = io.popen('fzf > /tmp/sam', 'w')
  for i=0,9 do fzf:write(i..'\n') end
  for i=0,25 do fzf:write(string.char(string.byte('a')+i)..'\n') end
  _ = fzf:close() or os.exit(1)
  return io.open('/tmp/sam'):read('l')
end

function split(s, delim)
  local parts = {}
  for part in (s..delim):gmatch('(.-)'..delim) do
    table.insert(parts, part)
  end
  return parts
end


function scrape(url, regex)
  local tab = {}
  for line in io.popen([[
    curl -s ']]..url..[[' \
    | htmlq '.fb-n a' \
    | sed '1d' \
    | grep -E ']]..regex..[[' \
    | sed -E 's|.*"([^"]+)">([^<]+)<.*|\1\t\2|' \
  ]]):lines('l')
  do
    table.insert(tab, split(line, '\t'))
  end

  return tab
end


function get_choice(tab)
  local fzf = io.popen('fzf > /tmp/sam', 'w')
  for i, v in ipairs(tab) do
    fzf:write(i..'  '..v[2]..'\n')
  end
  _ = fzf:close() or os.exit(1)

  local choice = io.open('/tmp/sam'):read('*n')
  return choice
end


function set_episode_titles(episodes)
  for _, v in pairs(episodes) do
    v[2] = v[2]:match('[Ss]%d+[Ee]%d+') or v[2]:match('[Ee][Pp]?%S*%s*%d+') or v[2]:match('[Oo][Vv][Aa]') or v[2]:match('%d+') or v[2]
  end
end


function series_to_eps(url_shows)
  local url_sam = url_shows:sub(url_shows:find('http://172.16.50.%d+'))

  local shows = scrape(url_shows, '')
  local choice = get_choice(shows)
  local url_show = url_sam..shows[choice][1]
  local seasons = scrape(url_show, 'Season')

  local episodes = {}
  for _, season in ipairs(seasons) do
    local eps = scrape(url_sam..season[1], '(mkv|mp4)')
    set_episode_titles(eps)
    for _, v in ipairs(eps) do
      v[1] = url_sam..v[1]
      table.insert(episodes, v);
    end
  end

  return episodes
end


function movie(url_mvs)
  local url_sam = url_mvs:match('http://172.16.50.%d+')
  local mvs = scrape(url_mvs, '')
  local choice = get_choice(mvs)
  local vids = scrape(url_sam..mvs[choice][1], '(mp4|mkv)')
  for _, v in pairs(vids) do
    v[1] = url_sam..v[1]
  end
  return vids
end


function write_to_m3u(filename, tab)
  local f = io.open(filename, 'w')
  f:write('#EXTM3U\n')
  for _, v in ipairs(tab) do
    f:write('#EXTINF:-1,'..v[2]..'\n')
    f:write(v[1]..'\n')
  end
  f:close()
end


main()


function pipe(val, ...)
  local fns = {...}
  for _, fn in ipairs(fns) do
    val = fn(val)
  end
  return val
end

function map(fn, tab)
  local result = {}
  for _, v in ipairs(tab) do
    table.insert(result, fn(v))
  end
  return result
end

function apply(fn, tab)
  for _, v in ipairs(tab) do
    fn(v)
  end
end
