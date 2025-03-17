
hook global BufCreate .*[.]vpp %{
	set-option buffer filetype vpp
}

hook -group vpp-highlight global WinSetOption filetype=vpp %{
	add-highlighter buffer/ ref vpp
}

rmhl shared/vpp

add-highlighter shared/vpp regions
add-highlighter shared/vpp/code default-region group
add-highlighter shared/vpp/comment region "comment \{" "\}" fill comment
add-highlighter shared/vpp/code/keywords regex "\b(set|create|protect|use|add|del)\b" 1:keyword
add-highlighter shared/vpp/code/adverbs regex "\b(via)\b" 1:attribute
add-highlighter shared/vpp/code/states regex "\b(enable|disable|up|down)\b" 1:variable
add-highlighter shared/vpp/code/type regex "\b(interface|tunnel|route|encap|decap|table)\b" 1:type
add-highlighter shared/vpp/code/protocol regex "\b(ip|udp|mpls|ipip|tap|ipv4|ipv6)\b" 1:module

