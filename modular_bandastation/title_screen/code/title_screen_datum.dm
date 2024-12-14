/datum/title_screen
	/// The preamble html that includes all styling and layout.
	var/title_html
	/// The current notice text, or null.
	var/notice
	/// The current title screen being displayed, as `/datum/asset_cache_item`
	var/datum/asset_cache_item/screen_image
	/// The character preview view.
	var/atom/movable/screen/map_view/char_preview/character_preview_view

/datum/title_screen/New(title_html, notice, screen_image_file)
	src.title_html = title_html
	src.notice = notice
	set_screen_image(screen_image_file)

/datum/title_screen/proc/set_screen_image(screen_image_file)
	if(!screen_image_file)
		return

	if(!isfile(screen_image_file))
		screen_image_file = fcopy_rsc(screen_image_file)

	screen_image = SSassets.transport.register_asset("[screen_image_file]", screen_image_file)

/datum/title_screen/proc/show_to(client/viewer)
	if(!viewer)
		return

	winset(viewer, "title_browser", "is-disabled=false;is-visible=true")
	winset(viewer, "status_bar", "is-visible=false")

	var/datum/asset/lobby_asset = get_asset_datum(/datum/asset/simple/lobby_fonts)
	var/datum/asset/fontawesome = get_asset_datum(/datum/asset/simple/namespaced/fontawesome)
	lobby_asset.send(viewer)
	fontawesome.send(viewer)

	SSassets.transport.send_assets(viewer, screen_image.name)

	viewer << browse(get_title_html(viewer, viewer.mob), "window=title_browser")

/datum/title_screen/proc/hide_from(client/viewer)
	if(viewer?.mob)
		winset(viewer, "title_browser", "is-disabled=true;is-visible=false")
		winset(viewer, "status_bar", "is-visible=true;focus=true")

/**
 * Get the HTML of title screen.
 */
/datum/title_screen/proc/get_title_html(client/viewer, mob/user)
	var/list/html = list(title_html)
	var/mob/dead/new_player/player = user

	html += {"<input type="checkbox" id="hide_menu">"}

	var/screen_image_url = SSassets.transport.get_asset_url(asset_cache_item = screen_image)
	if(screen_image_url)
		html += {"<img class="bg" src="[screen_image_url]">"}

	if(notice)
		html += {"
		<div class="container_notice">
			<p class="menu_notice">[notice]</p>
		</div>
	"}

	html += {"
		<div class="lobby_container">
			<img class="lobby_background pixelated" src="[SSassets.transport.get_asset_url(asset_name = "lobby_background.png")]">
	"}

	if(!SSticker || SSticker.current_state <= GAME_STATE_PREGAME)
		html += {"
			<a class="lobby_element lobby-ready" href='byond://?src=[REF(player)];toggle_ready=1'>
				<img class="pixelated" src="[SSassets.transport.get_asset_url(asset_name = "lobby_ready.png")]">
				<span id="ready" class="lobby-text [player.ready == PLAYER_READY_TO_PLAY ? "good" : "bad"]">ГОТОВ</span>
			</a>
		"}
	else
		html += {"
			<a class="lobby_element lobby-join" href='byond://?src=[REF(player)];late_join=1'>
				<img class="pixelated" src="[SSassets.transport.get_asset_url(asset_name = "lobby_join.png")]">
				<span class="lobby-text">ИГРАТЬ</span>
			</a>
		"}

	html += {"
		<a class="lobby_element lobby-observe" href='byond://?src=[REF(player)];observe=1'>
			<img class="pixelated" src="[SSassets.transport.get_asset_url(asset_name = "lobby_observe.png")]">
			<span class="lobby-text">СЛЕДИТЬ</span>
		</a>
	"}

	html += {"
		<a class="lobby_element lobby-character-setup" href='byond://?src=[REF(player)];character_setup=1'>
			<img class="pixelated" src="[SSassets.transport.get_asset_url(asset_name = "lobby_character-setup.png")]">
			<span class="lobby-text">НАСТРОЙКА ПЕРСОНАЖА</span>
		</a>
	"}

	html += {"
		<label class="lobby_element lobby-collapse" for="hide_menu">
			<img class="pixelated" src="[SSassets.transport.get_asset_url(asset_name = "lobby_collapse.png")]">
			<div class="toggle"></div>
		</a>
	"}

	html += {"</div>"}
	html += {"
		<script language="JavaScript">
			let ready_int = 0;
			const readyID = document.getElementById("ready");
			const ready_class = \[ "bad", "good" \];
			function toggle_ready(setReady) {
				if(setReady) {
					ready_int = setReady;
					readyID.classList.add(ready_class\[ready_int\]);
					readyID.classList.remove(ready_class\[1 - ready_int\]);
				} else {
					ready_int++;
					if(ready_int === ready_class.length)
						ready_int = 0;
					readyID.classList.add("good");
					readyID.classList.remove("bad");
				}
			}

			const character_name_slot = document.getElementById("character_slot");
			function update_current_character(name) {
				character_name_slot.textContent = name;
			}

			/* Return focus to Byond after click */
			function reFocus() {
				var focus = new XMLHttpRequest();
				focus.open("GET", "?src=[REF(player)];focus=1");
				focus.send();
			}

			document.addEventListener('mouseup', reFocus);
			document.addEventListener('keyup', reFocus);
		</script>
		"}

	html += "</body></html>"

	return html.Join()
