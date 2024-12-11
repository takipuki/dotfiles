#! /usr/bin/env lua

HELP = [[

stream youtube video/audio to mpv

Usage:
  yt [options] [query]

Options:
  -h                show this help
  -v                play video
  -n                print videos ids without playing
  -f<FORMAT>        yt-dlp format
  -s<QUERY>         interactively search and select videos (can be multiple)
  -i<VIDEO ID>      manually add id to play
]]

--- TODO directly given ids are played first; should play in the order of arguments
---      make searching a function and use it in getopts

MPD_HOST    = os.getenv("MPD_HOST") or "~/.local/share/mpd/socket"
SEARCH_URL  = "https://www.youtube.com/results?search_query="
SHOULD_PLAY = true          -- should play or just print the IDs
DLP_FORMAT  = "bestaudio"    -- play video or just audio
PLAYER_CMD  = "mpv "        -- media player


local p = assert(io.popen("tput cols", 'r'))
local COLS = tonumber(p:read())
p:close()
COLS = COLS > 100 and 100 or COLS


local interactive_searches = {}   -- choose from search results
local non_i_searches = {}         -- auto choose first result
local ids = {}                    -- ids in this table will be played

-- parsing args
for _, argv in ipairs(arg) do
	if string.sub(argv, 1, 1) == '-' then
		local opt, val = argv:match('-(%a)(.*)')
		if     opt == 'v' then DLP_FORMAT = "bv[height<=1080]+ba"
		elseif opt == 'f' then DLP_FORMAT = val
		elseif opt == 'n' then SHOULD_PLAY = false
		elseif opt == 's' then table.insert(interactive_searches, val)
		elseif opt == 'i' then table.insert(ids, val)
		elseif opt == 'h' then print(HELP); os.exit()
		else print("Unknown option "..opt) os.exit()
		end
	else
		table.insert(non_i_searches, argv)
	end
end


-- starting the non_i_search processes
local non_i_query_processes = {}
for _,query in ipairs(non_i_searches) do
	local cmd =
	'curl '..SEARCH_URL..(query:gsub("%s+", "+"))..' -s |'..
	'sed -n "s/^.*ytInitialData = \\({.*}\\);<\\/.*$/\\1/p" |'..
	'jq ".contents.twoColumnSearchResultsRenderer.primaryContents.sectionListRenderer.contents.[0].itemSectionRenderer.contents" |'..
	'jq ".[].videoRenderer | select(. != null)" |'..
	'jq -r ".videoId"'

	non_i_query_processes[query] = io.popen(cmd)
end

-- starting the i_search processes
local i_query_processes = {}
for _,query in ipairs(interactive_searches) do
	local cmd =
		'curl '..SEARCH_URL..(query:gsub("%s+", "+"))..' -s |'..
		'sed -n "s/^.*ytInitialData = \\({.*}\\);<\\/.*$/\\1/p" |'..
		'jq ".contents.twoColumnSearchResultsRenderer.primaryContents.sectionListRenderer.contents.[0].itemSectionRenderer.contents" |'..
		'jq ".[].videoRenderer | select(. != null)" |'..
		'jq -r ".videoId, .title.runs.[0].text, .lengthText.simpleText"'

	i_query_processes[query] = io.popen(cmd)

	-- e.g. output of above command
	-- 9C7RJx49ZgM
	-- Jonathan Blow criticizes Valve
	-- 4:45
end


-- reading i_search results and taking user choices
for query, process in pairs(i_query_processes) do
	local search_results = {}
	for i=0,9 do
		search_results[i+1] = process:read()
		print(string.format("%d %-"..(COLS-20)..'.'..(COLS-20).."s%10s",
		i, process:read(), process:read()))
	end
	process:close()

	io.write("Choose: ")
	local choice = io.read("n") or os.exit(1)
	io.write("\n")

	ids[query] = search_results[choice+1]
end

-- reading non_i_search results and reading first id
for query, process in pairs(non_i_query_processes) do
	local id = process:read()
	ids[query] = id
	process:close()
end


if not SHOULD_PLAY then
	for query, e in pairs(ids) do
		print(query, e)
	end
	os.exit(0)
end


function mpc(args)
	return "MPD_HOST="..MPD_HOST.." mpc -q "..args
end

-- starting dlp downloads
for query, id in pairs(ids) do
	local f_name = "'/tmp/"..query..".webm'"
	os.execute(
		"yt-dlp -q --no-warnings -o - -f '"..DLP_FORMAT.."' -- "..id.." > "..f_name
		.." && "..
		mpc("update --wait")
		.." && "..
		mpc("add "..(f_name:gsub("/tmp", "yt")))
		.." && "..
		mpc("play")
		.." &"
	)
end

