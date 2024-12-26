#define MAX_STATION_TRAIT_BUTTONS_VERTICAL 3

/**
 * Get the HTML of title screen.
 */
/datum/title_screen/proc/get_title_html(client/viewer, mob/user)
	var/screen_image_url = SSassets.transport.get_asset_url(asset_cache_item = screen_image)
	var/mob/dead/new_player/player = user
	var/list/html = list()
	html += {"
		<!DOCTYPE html>
		<html>
		<head>
			<title>Title Screen</title>
			<meta http-equiv="X-UA-Compatible" content="IE=edge">
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
			<style type='text/css'>
				[file2text(title_css)]
			</style>
		</head>
		<body>
	"}

	if(screen_image_url)
		html += {"<img id="screen_image" class="bg" src="[screen_image_url]" alt="Загрузка..." onerror="fix_image()">"}

	html += {"<div id="container_notice" class="[SStitle.notice ? "" : "hidden"]">[SStitle.notice]</div>"}
	html += {"<input type="checkbox" id="hide_menu">"}
	html += {"<div class="lobby_wrapper">"}
	html += {"
		<div class="lobby_container">
			<img class="lobby_background pixelated" src="[SSassets.transport.get_asset_url(asset_name = "lobby_background.png")]">
			<img class="lobby_shutter pixelated" src="[SSassets.transport.get_asset_url(asset_name = "lobby_shutter.png")]">
	"}

	html += {"<div class="lobby_buttons-center">"}
	if(!SSticker || SSticker.current_state <= GAME_STATE_PREGAME)
		html += create_main_button(player, "toggle_ready", "ГОТОВ", player.ready == PLAYER_READY_TO_PLAY ? "good" : "bad")
	else
		html += create_main_button(player, "late_join", "ИГРАТЬ")

	html += create_main_button(player, "observe", "СЛЕДИТЬ")
	html += create_main_button(player, "character_setup", "НАСТРОЙКА ПЕРСОНАЖА")
	html += {"<div class="lobby_element lobby-name"><span id="character_name">[player.client.prefs.read_preference(/datum/preference/name/real_name)]</span></div>"}
	html += {"</div>"}

	html += {"<div class="lobby_buttons-bottom">"}
	html += create_icon_button(player, "changelog", "Открыть чейнджлог")
	html += create_icon_button(player, "settings", "Настройки игры")
	html += create_icon_button(player, "manifest", "Манифест персонала")
	html += create_icon_button(player, "wiki", "Перейти на вики")
	html += {"</div>"}

	html += {"<div id="lobby_admin" class="lobby_buttons-right hidden">"}
	html += create_icon_button(player, "picture", "Сменить изображение", "right")
	html += create_icon_button(player, "notice", "Оставить уведомление", "right")
	html += create_icon_button(player, "css", "Заменить CSS лобби", "right")
	html += {"</div>"}

	if(length(GLOB.lobby_station_traits))
		html += {"<div class="lobby_buttons-left">"}

		var/number = 0
		for(var/datum/station_trait/job/trait as anything in GLOB.lobby_station_traits)
			if(!istype(trait))
				continue // Skip trait if it is not a job

			if(!trait.can_display_lobby_button(player.client))
				continue

			if(number > MAX_STATION_TRAIT_BUTTONS_VERTICAL) // 3 is a maximum
				break

			number++
			var/traitID = replacetext(replacetext("[trait.type]", "/datum/station_trait/job/", ""), "/", "-")
			var/assigned = LAZYFIND(trait.lobby_candidates, player)
			html += {"
				<a id="lobby-trait-[number]" class="lobby_button lobby_element" href='byond://?src=[REF(user)];trait_signup=[trait.name];id=[number]'>
					<div class="toggle">
						<img class="pixelated indicator trait_active [assigned ? "" : "hidden"]" src="[SSassets.transport.get_asset_url(asset_name = "lobby_active.png")]">
						<img class="pixelated indicator trait_disabled [!assigned ? "" : "hidden"]" src="[SSassets.transport.get_asset_url(asset_name = "lobby_disabled.png")]">
						<img class="pixelated indicator" src="[SSassets.transport.get_asset_url(asset_name = "lobby_highlight.png")]">
					</div>
					<img class="pixelated" src="[SSassets.transport.get_asset_url(asset_name = "lobby_[traitID].png")]">
					<div class="lobby-tooltip" data-position="left">
						<span class="lobby-tooltip-title">[trait.name]</span>
						<span class="lobby-tooltip-content">[trait.button_desc]</span>
					</div>
				</a>
			"}

		html += {"</div>"}

	html += {"
		<label class="lobby_element lobby-collapse" for="hide_menu">
			<span id="collapse" class="lobby-text toggle good">˄</span>
			<img class="pixelated" src="[SSassets.transport.get_asset_url(asset_name = "lobby_collapse.png")]">
		</label>
	"}

	html += {"</div></div></body>"}
	html += {"
		<script language="JavaScript">
			function call_byond(href, value) {
				const request = new XMLHttpRequest();
				const url = "?src=[REF(player)];" + href + "=" + value;
				request.open("GET", url);
				request.send();
			}

			function throw_runtime(message) {
				call_byond("runtime", message);
			}

			let ready_int = 0;
			const readyID = document.querySelector(".lobby-toggle_ready");
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

			function job_sign(assign, id) {
				/* I FUCKING HATE IE */
				let traitID;
				let trait_active;
				let trait_disabled;

				if(!id) {
					return
				}

				if (id === "1") {
					traitID = "lobby-trait-1";
				} else if (id === "2") {
					traitID = "lobby-trait-2";
				} else if (id === "3"){
					traitID = "lobby-trait-3";
				} else {
					return
				}

				trait_active = document.getElementById(traitID).querySelector(".trait_active");
				trait_disabled = document.getElementById(traitID).querySelector(".trait_disabled");

				if(assign === "true") {
					trait_active.classList.remove("hidden");
					trait_disabled.classList.add("hidden");
				} else {
					trait_active.classList.add("hidden");
					trait_disabled.classList.remove("hidden");
				}
			}

			const admin_buttons = document.getElementById("lobby_admin")
			function admin_buttons_visibility(visible) {
				if(visible === "true") {
					admin_buttons.classList.remove("hidden")
				} else {
					admin_buttons.classList.add("hidden")
				}
			}

			const notice_container = document.getElementById("container_notice");
			function update_notice(notice) {
				if(notice === undefined) {
					notice_container.classList.add("hidden");
					notice_container.textContent = "";
				} else {
					notice_container.classList.remove("hidden");
					notice_container.textContent = notice;
				}
			}

			const character_name_slot = document.getElementById("character_name");
			function update_character_name(name) {
				character_name_slot.textContent = name;
			}

			let collapsed = false;
			const collapse = document.getElementById("collapse");
			function update_collapse() {
				call_byond("collapse", true)
				collapsed = !collapsed;
				if(collapsed) {
					collapse.textContent = "˅";
				} else {
					collapse.textContent = "˄";
				}
			}

			let image_src;
			const image_container = document.getElementById("screen_image");
			function update_image(image) {
				image_src = image;
				image_container.src = image_src;
			}

			let attempts = 0;
			const maxAttempts = 3;
			function fix_image() {
				const img = new Image();
				img.src = image_src;
				if(img.naturalWidth === 0 || img.naturalHeight === 0) {
					if(attempts === maxAttempts) {
						attempts = 0;
						throw_runtime("Изображение не получилось загрузить");
						return;
					}

					attempts++;
					setTimeout(function() {
						throw_runtime("Изображение не загрузилось с первого раза, попытка " + attempts + " из " + maxAttempts);
						fix_image();
					}, 1000);
				} else {
					attempts = 0;
					image_container.src = image_src;
					throw_runtime("Фикс изображения помог с первого раза");
					return;
				}
			}

			/* Return focus to Byond after click */
			function reFocus() {
				call_byond("focus", true);
			}

			document.addEventListener('keyup', reFocus);
			document.addEventListener('mouseup', reFocus);
			collapse.addEventListener('mouseup', update_collapse);
		</script>
	"}

	html += "</html>"

	return html.Join()

#undef MAX_STATION_TRAIT_BUTTONS_VERTICAL
