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

	html += {"<div class="container_menu">"}
	html += {"
		<div class="container_logo">
			<div class="logo_and_preview">
				<img class="logo" src="[SSassets.transport.get_asset_url(asset_name = "logo.png")]">
			</div>
			<div class="character_info">
				<span class="character">На смену прибывает...</span>
				<span class="character" id="character_slot">[uppertext(viewer.prefs.read_preference(/datum/preference/name/real_name))]</span>
			</div>
		</div>
	"}
	html += {"<div class="container_buttons">"}

	if(!SSticker || SSticker.current_state <= GAME_STATE_PREGAME)
		html += {"<a class="menu_button [player.ready == PLAYER_READY_TO_PLAY ? "good" : "bad"]" id="ready" href='byond://?src=[REF(player)];toggle_ready=1'>[player.ready == PLAYER_READY_TO_PLAY ? "Готов" : "Не готов"]</a>"}
	else
		html += {"
			<a class="menu_button" href='byond://?src=[REF(player)];late_join=1'>Присоединиться</a>
			<a class="menu_button" href='byond://?src=[REF(player)];view_manifest=1'>Список экипажа</a>
		"}

	html += {"<a class="menu_button" href='byond://?src=[REF(player)];observe=1'>Наблюдать</a>"}
	html += {"
		<hr>
		<a class="menu_button" href='byond://?src=[REF(player)];character_setup=1'>Настройка персонажа</a>
		<a class="menu_button" href='byond://?src=[REF(player)];game_options=1'>Настройки игры</a>
		<hr>
	"}

	if(check_rights_for(viewer, R_FUN))
		html += {"
			<a class="menu_button admin" href='byond://?src=[REF(player)];change_picture=1'>Изменить изображение</a>
			<a class="menu_button admin" href='byond://?src=[REF(player)];leave_notice=1'>Оставить уведомление</a>
			<hr>
		"}

	html += {"
		<div class="container_links">
			<a class="link_button" href='byond://?src=[REF(player)];wiki=1'><i class="fab fa-wikipedia-w"></i></a>
			<a class="link_button" href='byond://?src=[REF(player)];discord=1'><i class="fab fa-discord"></i></a>
			<a class="link_button" title="Чейнджлог" href='byond://?src=[REF(player)];changelog=1'><i class="fas fa-newspaper"></i></a>
		</div>
	"}
	html += {"</div>"}
	html += {"<label class="hide_button" for="hide_menu"><i class="fas fa-angles-left"></i></label>"}
	html += {"
		<script language="JavaScript">
			let ready_int = 0;
			const readyID = document.getElementById("ready");
			const ready_marks = \[ "Не готов", "Готов" \];
			const ready_class = \[ "bad", "good" \];
			function toggle_ready(setReady) {
				if(setReady) {
					ready_int = setReady;
					readyID.innerHTML = ready_marks\[ready_int\];
					readyID.classList.add(ready_class\[ready_int\]);
					readyID.classList.remove(ready_class\[1 - ready_int\]);
				} else {
					ready_int++;
					if(ready_int === ready_marks.length)
						ready_int = 0;
					readyID.innerHTML = ready_marks\[ready_int\];
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
