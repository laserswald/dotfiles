#!/bin/sh

# Pomodoro tools
POMO_WORK_LEN=${POMO_WORK_LEN:-25}
POMO_SHORT_BREAK=${POMO_SHORT_BREAK:-5}
POMO_WORK_GROUP=${POMO_WORK_GROUP:-4}
POMO_LONG_BREAK=${POMO_LONG_BREAK:-10}

# pomo() {
#     start_time $1
#     sleep $POMO_WORK_LEN

#     notify-send "pomo" "Pomodoro done! Starting your break."
#     end_time $1
#     sleep $POMO_SHORT_BREAK

#     notify-send "pomo" "Breaktime's over."
# }

