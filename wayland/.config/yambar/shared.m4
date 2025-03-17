shared: 
    on-tag-click: &shared-on-tag-click
        left: sh -c 'riverctl set-focused-tags $((1 << ({id} - 1)))'
        right: sh -c 'riverctl toggle-focused-tags $((1 << ({id} - 1)))'

    river-tags: &shared-river-tags
        map:
            tag: occupied
            values:
                false: {empty: {}}
                true:
                    map:
                        tag: state
                        default:
                            string:
                                margin: 5
                                text: "{id}"
                                foreground: *foreground
                                on-click: *shared-on-tag-click 
                        values:
                            unfocused:
                                string:
                                    margin: 5
                                    text: "{id}"
                                    foreground: *tag-unfocused
                                    on-click: *shared-on-tag-click
                            focused:
                                string:
                                    margin: 5
                                    text: "{id}"
                                    foreground: *tag-focused
                                    on-click: *shared-on-tag-click
                            invisible:
                                string:
                                    margin: 5
                                    text: "{id}"
                                    foreground: *tag-invisible
                                    on-click: *shared-on-tag-click
    status: &shared-status    
        - battery:
            name: BAT0
            poll-interval: 30
            content:
                list:
                    items:
                        - string:
                            text: "BAT "
                            foreground: *status-indicator
                        - progress-bar: 
                            tag: capacity
                            length: 10
                            start: {string: {text: ""}}
                            end: {string: {text: ""}}
                            indicator: {string: {text: ""}}
                            fill: {string: {text: "━"}}
                            empty: {string: {text: "─"}}
                        - string:
                            text: " │ "
        - alsa:
            card: PipeWire
            mixer: Master
            content: 
                list:
                    items:
                        - string:
                            text: "VOL "
                            foreground: *status-indicator
                        - string: 
                            text: "{volume}"
                        - string:
                            text: " │ "
                    on-click:
                       left: pavucontrol
        - clock:
            content:
                list:
                    items:
                        - string:
                            text: "DTM "
                            foreground: *status-indicator
                        - string: 
                            text: "{date} - {time}"

