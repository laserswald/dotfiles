
(defvar lazr-paths
  (list "/Users/bdavenport-ray/.cargo/bin"
	"/Users/bdavenport-ray/.config/composer/vendor/bin/"
	"/Users/bdavenport-ray/.local/bin"
	"/Users/bdavenport-ray/.luarocks/bin"
	"/Users/bdavenport-ray/bin"
	"/Users/bdavenport-ray/src/go/bin"
	"/bin"
	"/go/bin"
	"/sbin"
	"/usr/bin"
	"/usr/local/bin"
	"/usr/local/lib/ruby/gems/2.7.0/bin"
	"/usr/local/opt/ruby/bin"
	"/usr/sbin"))

(dolist (path lazr-paths)
  (add-to-list 'exec-path path))

(provide 'shell)
