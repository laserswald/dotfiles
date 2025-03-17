include(`selenized.m4')
include(`shared.m4')

bar:
    height: 32
    location: top
    background: *background
    foreground: *foreground
    font: "Fira Code Retina:size=24"
    monitor: DP-1
    left:
        - river:
            title: {empty: {}}
            content: *shared-river-tags
    center:
        - river:
            title: {string: { text: "{title}"}}
            content: {empty: {}}
    right: *shared-status
