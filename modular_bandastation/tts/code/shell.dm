#define SHELLEO_ERRORLEVEL 1
#define SHELLEO_STDOUT 2
#define SHELLEO_STDERR 3

#define SHELLEO_NAME "data/shelleo."
#define SHELLEO_ERR ".err"
#define SHELLEO_OUT ".out"

/proc/apply_sound_effects(list/effects, filename_input, filename_output)
	if(!length(effects))
		CRASH("Invalid sound effect chosen.")

	var/list/ffmpeg_arguments = list()
	var/complex = FALSE
	for(var/datum/singleton/sound_effect/effect as anything in effects)
		if(effect.complex)
			ffmpeg_arguments = list(effect.ffmpeg_arguments)
			complex = TRUE
			break

		ffmpeg_arguments |= effect.ffmpeg_arguments

	var/taskset = CONFIG_GET(string/ffmpeg_cpuaffinity) ? "taskset -ac [CONFIG_GET(string/ffmpeg_cpuaffinity)]" : ""
	var/filter_part = complex ? ffmpeg_arguments.Join() : {"-filter:a "[ffmpeg_arguments.Join(", ")]""}

	var/command = {"[taskset] ffmpeg -y -hide_banner -loglevel error -i [filename_input] [filter_part] [filename_output]"}
	var/list/output = world.shelleo(command)

	var/errorlevel = output[SHELLEO_ERRORLEVEL]
	var/stdout = output[SHELLEO_STDOUT]
	var/stderr = output[SHELLEO_STDERR]
	if(errorlevel)
		var/effect_types = effects.Join("; ")
		log_runtime("Error: apply_sound_effects([effect_types], [filename_input], [filename_output]) - See debug logs.")
		logger.Log(LOG_CATEGORY_DEBUG, "apply_sound_effects([effect_types], [filename_input], [filename_output]) STDOUT: [stdout]")
		logger.Log(LOG_CATEGORY_DEBUG, "apply_sound_effects([effect_types], [filename_input], [filename_output]) STDERR: [stderr]")
		return FALSE
	return TRUE

/datum/singleton/sound_effect
	var/complex = FALSE
	var/suffix
	var/ffmpeg_arguments
	/// If set to TRUE, this effect will ignore all other filters.

/datum/singleton/sound_effect/radio
	suffix = "_radio"
	ffmpeg_arguments = "highpass=f=1000, lowpass=f=3000, acrusher=1:1:50:0:log"

/datum/singleton/sound_effect/robot
	suffix = "_robot"
	ffmpeg_arguments = "afftfilt=real='hypot(re,im)*sin(0)':imag='hypot(re,im)*cos(0)':win_size=1024:overlap=0.5, deesser=i=0.4, volume=volume=1.5"

/datum/singleton/sound_effect/megaphone
	suffix = "_megaphone"
	ffmpeg_arguments = "highpass=f=500, lowpass=f=4000, volume=volume=10, acrusher=1:1:45:0:log"

/datum/singleton/sound_effect/announcement
	complex = TRUE
	suffix = "_announcement"
	ffmpeg_arguments = {"\
		-i ./tools/tts/tts-api/RoomImpulse.wav -filter_complex \
		"[0:a]apad=pad_dur=2[input_padded]; [1:a]apad=whole_len=10000[impulse_padded]; \
		[impulse_padded]volume=5[impulse]; [input_padded][impulse]afir=dry=10:wet=10[reverb]; \
		[0:a][reverb]amix=inputs=2:weights=8 1[mixed]; [mixed]highpass=f=200,lowpass=f=14000[filtered]; \
		[filtered]deesser=i=0.4[deessed]; [deessed]acrusher=mix=0.1:mode=lin:aa=1:samples=250[crushed]; \
		[crushed]equalizer=f=4000:t=h:width=2000:g=8"\
	"}

#undef SHELLEO_ERRORLEVEL
#undef SHELLEO_STDOUT
#undef SHELLEO_STDERR

#undef SHELLEO_NAME
#undef SHELLEO_ERR
#undef SHELLEO_OUT
