TITLE = "Magit development July 2008 - $(shell date '+%B %Y')"

ARGS  =
ARGS += --path magit
ARGS += --file-idle-time 0 --max-files 0
ARGS += --user-scale 0.7
ARGS += --highlight-users
ARGS += --user-image-dir magit_avatars

ARGS_A  = $(ARGS)
ARGS_A += --title $(TITLE)
ARGS_A += --hide mouse,progress
ARGS_A += --seconds-per-day 0.1
ARGS_A += --auto-skip-seconds 0.7
ARGS_A += --bloom-intensity 1.4

ARGS_B  = $(ARGS)
ARGS_B += --hide bloom,date,dirnames,filenames,mouse,progress
ARGS_B += --seconds-per-day 0.005
ARGS_B += --auto-skip-seconds 0.035

LOGO = --logo magit_logo/magit-logo-200x200px-transparent-bg.png

SOLARIZED  =
SOLARIZED += --background-colour fdf6e3
SOLARIZED += --font-colour ff491b
SOLARIZED += --highlight-colour ff491b
SOLARIZED += --selection-colour ff491b
SOLARIZED += --dir-colour ff491b
SOLARIZED += --caption-colour ff491b

OUTPUT_ARGS  =
OUTPUT_ARGS += --output-ppm-stream -
OUTPUT_ARGS += --output-framerate 30

gource-700x700.mkv:
	echo gource -700x700 $(SOLARIZED) $(ARGS_B) $(OUTPUT_ARGS) | \
	ffmpeg -f image2pipe -c:v ppm -i - -c:v ffv1 $@

gource-700x700.png: gource-700x700.mkv
	ffmpeg -ss 00:02:50 -i $< -frames:v 1 $@

gource-700x700.webm: gource-700x700.mkv
	ffmpeg -i $< -c:v libvpx -crf 10 -b:v 1M $@

gource-1920x1080.mp4:
	gource -1920x1080 $(LOGO) $(ARGS_A) $(OUTPUT_ARGS) | \
	ffmpeg -f image2pipe -c:v ppm -i - -c:v libx264 $@
